# dotfiles

Configuration of my setup for osx/archlinux.

![vanity-image](https://user-images.githubusercontent.com/222507/160403193-f82e50be-5653-46a7-aa57-bdde49ba344a.png)

## Daily Copilot review on the ICA laptop

After `make switch-ica`, a user launch agent reviews the previous day's local
Copilot tool calls at 08:00. Day boundaries use `Europe/Stockholm`; the calendar
trigger uses the Mac's local clock. The laptop must be awake and the user agent
loaded. Launch-time catch-up runs only after 08:00 and processes missed days
since the last successful scheduled review. The first run starts with yesterday.

Reports are private files under
`~/.local/share/copilot-daily-review/YYYY-MM-DD/`:

- `commands.md`: chronological tool/command inventory with completion status.
- `activity.json`: filtered activity and repetition counts.
- `improvements.md`: evidence-based suggestions, without automatic changes.
- `session.md`: Markdown export of the dated Copilot review session.

Review sessions are named `Daily tool review YYYY-MM-DD`. Reruns skip completed
reports; forced or failed reruns reuse a session when its local log exists.
Days without activity still get a dated review session and a report stating that
no activity was recorded. Concurrent runs are locked out.

```sh
copilot-daily-review                         # Review yesterday
copilot-daily-review --date 2026-11-18        # Review a particular day
copilot-daily-review --date 2026-11-18 --force
copilot-daily-review --collect-only          # Inventory without a model call
```

The collector reads local `events.jsonl` files, including sessions started on
earlier days, and ignores its own review sessions. It does not collect direct
terminal history, user messages, tool output, or file-edit bodies. Shell
here-document bodies are omitted. Common credential patterns are redacted, but
redaction is best-effort: command arguments can still contain sensitive data.
Keep reports private and inspect `--collect-only` output before sharing it.

The reviewer uses the pinned Nix Copilot CLI and the user's existing Copilot
authentication. It sends a bounded, filtered sample to Copilot for analysis,
with tool access and account-history sync disabled; it does not create gists.
The full inventory remains local. This is not a lossless raw transcript.
Authentication or model failures leave the inventory in place for retry.
Logs are in `~/Library/Logs/copilot-daily-review*.log`. The system rebuild must be
applied by the user; committing the configuration does not activate the job.
