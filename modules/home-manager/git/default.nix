{
  config,
  pkgs,
  host ? {},
  ...
}: let
  # Per-host git identity from hosts.nix; hosts without a `git` block get the
  # personal defaults below.
  gitCfg = host.git or {};
in {
  programs.git = {
    enable = true;
    lfs.enable = true;

    signing.key = gitCfg.signingKey or "0179B829112D6737";

    settings = {
      user = {
        name = "Pradip Caulagi";
        email = gitCfg.email or "caulagi@gmail.com";
      };
      color.ui = true;
      commit.gpgsign = true;
      core.ignorecase = false;
      diff.submodule = "log";
      github.user = gitCfg.githubUser or "caulagi";
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
