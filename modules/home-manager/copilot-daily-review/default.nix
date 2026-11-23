{
  config,
  lib,
  pkgs,
  ...
}: let
  review = pkgs.writeShellScriptBin "copilot-daily-review" ''
    export PYTHONTZPATH=${pkgs.tzdata}/share/zoneinfo
    exec ${pkgs.python3}/bin/python3 ${./daily_review.py} \
      --copilot ${lib.getExe pkgs.github-copilot-cli} "$@"
  '';
in
  lib.mkIf (pkgs.stdenv.hostPlatform.isDarwin && config.home.username == "icw099") {
    home.packages = [review];

    launchd.agents.copilot-daily-review = {
      enable = true;
      config = {
        ProgramArguments = ["${review}/bin/copilot-daily-review" "--scheduled"];
        StartCalendarInterval = [
          {
            Hour = 8;
            Minute = 0;
          }
        ];
        RunAtLoad = true;
        ProcessType = "Background";
        EnvironmentVariables = {
          HOME = config.home.homeDirectory;
          PATH = lib.makeBinPath [pkgs.coreutils pkgs.git pkgs.bash];
        };
        StandardOutPath = "${config.home.homeDirectory}/Library/Logs/copilot-daily-review.log";
        StandardErrorPath = "${config.home.homeDirectory}/Library/Logs/copilot-daily-review-error.log";
      };
    };
  }
