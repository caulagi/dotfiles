import datetime as dt
import json
from pathlib import Path
import subprocess
import tempfile
from types import SimpleNamespace
import unittest
from unittest.mock import patch

import daily_review as review


class DailyReviewTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.history = self.root / "history"
        self.output = self.root / "reports"
        self.history.mkdir()
        self.output.mkdir()
        self.day = dt.date(2026, 11, 18)
        self.args = SimpleNamespace(
            history=self.history, output=self.output, copilot="copilot",
            force=False, collect_only=False,
        )

    def log(self, name, events):
        directory = self.history / name
        directory.mkdir()
        path = directory / "events.jsonl"
        path.write_text("".join(json.dumps(event) + "\n" for event in events))
        return path

    def start(self, call="call-1", time="2026-11-18T12:00:00Z", command="git status"):
        return {
            "type": "tool.execution_start", "id": call, "timestamp": time,
            "data": {"toolCallId": call, "toolName": "bash", "arguments": {"command": command}},
        }

    def session(self, cwd="/project", session="session-1"):
        return {"type": "session.start", "data": {"sessionId": session, "context": {"cwd": cwd}}}

    def test_local_date_boundaries_and_next_day_completion(self):
        self.log("one", [
            self.session(),
            self.start("before", "2026-11-17T22:59:59Z"),
            self.start("midnight", "2026-11-17T23:00:00Z"),
            self.start("late", "2026-11-18T22:59:59Z"),
            self.start("after", "2026-11-18T23:00:00Z"),
            {"type": "tool.execution_complete", "data": {
                "toolCallId": "late", "success": True,
                "shellExecution": {"exitCode": 2},
                "result": {"content": "SECRET OUTPUT MUST NOT BE COLLECTED"},
            }},
        ])
        calls = review.collect(self.history, self.day, self.output)["calls"]
        self.assertEqual([call["call"] for call in calls], ["midnight", "late"])
        self.assertEqual(calls[0]["time"], "2026-11-18T00:00:00+01:00")
        self.assertEqual(calls[-1]["exit_code"], 2)
        self.assertNotIn("SECRET OUTPUT", json.dumps(calls))

    def test_forks_deduplicated_and_review_sessions_excluded(self):
        self.log("one", [self.session(), self.start()])
        self.log("fork", [self.session(), self.start()])
        self.log("review", [self.session(str(self.output / str(self.day))), self.start("self")])
        calls = review.collect(self.history, self.day, self.output)["calls"]
        self.assertEqual(len(calls), 1)
        self.assertEqual(calls[0]["call"], "call-1")

    def test_incomplete_json_line_preserves_readable_calls_and_warns(self):
        path = self.log("one", [self.session(), self.start()])
        with path.open("a") as stream:
            stream.write('{"type":')
        activity = review.collect(self.history, self.day, self.output)
        self.assertEqual(len(activity["calls"]), 1)
        self.assertEqual(len(activity["warnings"]), 1)

    def test_freeform_patch_records_paths_without_file_contents_or_false_warnings(self):
        event = self.start()
        event["data"]["toolName"] = "apply_patch"
        event["data"]["arguments"] = (
            "*** Begin Patch\n*** Update File: config.nix\n+private_source\n*** End Patch"
        )
        self.log("one", [self.session(), event])
        activity = review.collect(self.history, self.day, self.output)
        self.assertEqual(activity["warnings"], [])
        self.assertIn("config.nix", activity["calls"][0]["details"])
        self.assertNotIn("private_source", activity["calls"][0]["details"])

    def test_redaction_and_source_body_omission(self):
        command = (
            "TOKEN=topsecret123 gh api --token 'anothersecret' "
            "-H 'Authorization: Bearer abcdef123' "
            "https://user:password@example.com?api_key=keysecret"
        )
        redacted = review.details({"command": command})
        for secret in ("topsecret123", "anothersecret", "abcdef123", "keysecret", "user:password"):
            self.assertNotIn(secret, redacted)
        detail = review.details({"command": "python - <<'PY'\nprivate_source = 1\nPY"})
        self.assertNotIn("private_source", detail)
        self.assertIn("contents omitted", detail)
        self.assertNotIn("private body", review.details({"body": "private body", "issue_key": "BD-1"}))

    def test_prompt_is_bounded_and_prioritises_failures(self):
        activity = {
            "date": str(self.day), "warnings": [], "repeated_calls": [],
            "calls": [
                {"time": str(i), "call": str(i), "details": "x" * 10_000,
                 "success": i != 99, "exit_code": 0}
                for i in range(100)
            ],
        }
        text = review.prompt(activity)
        sample = json.loads(text[len(review.PROMPT):])
        self.assertLess(len(text), review.PROMPT_LIMIT + len(review.PROMPT) + 100)
        self.assertEqual(sample["calls"][0]["call"], "99")
        self.assertLess(sample["sampled_calls"], 100)

    def test_schedule_waits_until_eight_and_catches_up_after_absence(self):
        now = dt.datetime(2026, 11, 19, 7, 59, tzinfo=review.TIMEZONE)
        self.assertEqual(review.scheduled_days(self.output, now), [])
        now = now.replace(hour=8)
        self.assertEqual(review.scheduled_days(self.output, now), [self.day])
        (self.output / ".last-scheduled-date").write_text("2026-11-16")
        self.assertEqual(review.scheduled_days(self.output, now), [dt.date(2026, 11, 17), self.day])
        (self.output / ".last-scheduled-date").write_text(str(self.day))
        self.assertEqual(review.scheduled_days(self.output, now), [])

    @patch.object(review.subprocess, "run")
    def test_review_uses_no_tools_saves_report_and_skips_duplicate_run(self, run):
        self.log("one", [self.session(), self.start()])
        run.return_value = subprocess.CompletedProcess([], 0, "## Improvements\nUse targeted searches.", "")
        review.review_day(self.args, self.day)
        directory = self.output / str(self.day)
        self.assertTrue((directory / "commands.md").exists())
        self.assertIn("targeted searches", (directory / "improvements.md").read_text())
        command = run.call_args.args[0]
        self.assertIn("--available-tools=", command)
        self.assertIn("--sync-session=off", command)
        self.assertIn("Daily tool review 2026-11-18", command)
        self.assertIn("git status", run.call_args.kwargs["input"])
        review.review_day(self.args, self.day)
        self.assertEqual(run.call_count, 1)

    @patch.object(review.subprocess, "run")
    def test_retry_resumes_existing_daily_session_without_marking_failure_done(self, run):
        self.log("one", [self.session(), self.start()])
        directory = self.output / str(self.day)
        self.log("review", [self.session(str(directory), "existing-review")])
        run.return_value = subprocess.CompletedProcess([], 1, "", "Authentication failed")
        with self.assertRaises(ValueError):
            review.review_day(self.args, self.day)
        self.assertFalse((directory / "improvements.md").exists())
        self.assertIn("existing-review", run.call_args.args[0])
        self.assertIn("--resume", run.call_args.args[0])
        self.assertTrue((directory / "commands.md").exists())

    @patch.object(review.subprocess, "run")
    def test_no_activity_still_creates_a_daily_review_session(self, run):
        self.log("one", [self.session()])
        run.return_value = subprocess.CompletedProcess([], 0, "No local Copilot tool calls recorded.", "")
        review.review_day(self.args, self.day)
        self.assertIn("No local", (self.output / str(self.day) / "improvements.md").read_text())
        run.assert_called_once()
        self.assertIn("Daily tool review 2026-11-18", run.call_args.args[0])

    def test_missing_history_is_not_reported_as_no_activity(self):
        self.args.history = self.root / "missing"
        with self.assertRaises(ValueError):
            review.review_day(self.args, self.day)
        self.assertFalse((self.output / str(self.day) / "improvements.md").exists())

    @patch.object(review, "review_day", side_effect=ValueError("review failed"))
    def test_failed_scheduled_review_does_not_advance_watermark(self, run):
        now = dt.datetime(2026, 11, 19, 8, tzinfo=review.TIMEZONE)
        with patch.object(review.dt, "datetime") as clock:
            clock.now.return_value = now
            with self.assertRaises(ValueError):
                review.main([
                    "--history", str(self.history), "--output", str(self.output),
                    "--scheduled",
                ])
        self.assertEqual(
            (self.output / ".last-scheduled-date").read_text().strip(), "2026-11-17"
        )
        self.assertEqual(
            review.scheduled_days(self.output, now + dt.timedelta(days=1)),
            [dt.date(2026, 11, 18), dt.date(2026, 11, 19)],
        )


if __name__ == "__main__":
    unittest.main()
