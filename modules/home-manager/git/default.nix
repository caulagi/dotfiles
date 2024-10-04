{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "Pradip Caulagi";
    userEmail = "caulagi@gmail.com";
    signing.key = "0179B829112D6737";

    extraConfig = {
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
