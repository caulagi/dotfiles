# https://nix-community.github.io/home-manager/options.html
{pkgs, ...}: {
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    awscli2
    ko
    go
    gzip
    httpie
    colima
    curl
    docker
    duf
    (
      google-cloud-sdk.withExtraComponents
      (with google-cloud-sdk.components; [
        gke-gcloud-auth-plugin
        gcloud-man-pages
      ])
    )
    kubectl
    fd
    pre-commit
    hugo
    gosec
    jq
    less
    nixpkgs-fmt
    ripgrep
    shellcheck
    watch
  ];
  home.sessionVariables = {
    HISTFILE = "$XDG_DATA_HOME/bash_history";
    PAGER = "less";
    CLICLOLOR = 1;
    PATH = "$PATH:$HOME/go/bin";
  };

  # https://nix-community.github.io/home-manager/options.html
  programs.zoxide = {
    enable = true;
    options = ["--cmd j"];
    enableBashIntegration = true;
  };

  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;
  programs.eza.enable = true;

  programs.bash.enable = true;
  programs.bash.enableCompletion = true;

  programs.direnv.enable = true;
  programs.direnv.enableBashIntegration = true;

  programs.bash.shellAliases = {
    sloc = "scc -c --no-cocomo";
    archlinux = "docker run -it --rm --platform linux/amd64 archlinux";
    k = "kubecolor";
    ll = "eza -alh --group-directories-first";
    sts = "aws sts get-caller-identity";
    nixswitch = "darwin-rebuild switch --flake ~/mac-nix/.#";
    nixsearch = "nix search nixpkgs";
    nixup = "pushd ~/mac-nix; nix flake update; nixswitch; popd";
  };

  programs.bash.initExtra = ''
    PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
    shopt -s histappend

    # search bash history
    h () {
      rg -a --sort path "$@" ~/bash_history/
    }
  '';

  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
  };
}
