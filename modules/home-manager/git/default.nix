{
  config,
  pkgs,
  host ? {},
  ...
}: let
  isWsl = host.isWsl or false;
in {
  programs.git = {
    enable = true;
    lfs.enable = true;

    signing.key =
      if isWsl
      then "E2B5C519C7475958"
      else "0179B829112D6737";

    settings = {
      user = {
        name = "Pradip Caulagi";
        email =
          if isWsl
          then "pradip.caulagi@ica.se"
          else "caulagi@gmail.com";
      };
      color.ui = true;
      commit.gpgsign = true;
      core.ignorecase = false;
      diff.submodule = "log";
      github.user = "caulagi";
      init.defaultBranch = "main";
      pager.branch = false;
      pull.ff = "only";
      pull.rebase = true;
      push.autoSetupRemote = true;
      push.default = "simple";
      push.recurseSubmodules = "on-demand";
      rebase.autoStash = true;
      status.submoduleSummary = "1";
    };
  };
}
