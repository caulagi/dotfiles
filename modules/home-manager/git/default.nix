{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    lfs.enable = true;

    signing.key = "0179B829112D6737";

    settings = {
      user = {
        name = "Pradip Caulagi";
        email = "caulagi@gmail.com";
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
      url = {
        "ssh://git@github.com/" = {
          insteadOf = "https://github.com/";
        };
      };
    };
  };
}
