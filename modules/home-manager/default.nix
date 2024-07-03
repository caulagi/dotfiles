# https://nix-community.github.io/home-manager/options.html
{pkgs, ...}: {
  home.stateVersion = "23.11";

  imports = [
    ./bat
    ./fish
    ./git
    ./neovim
    ./python
    ./starship
    ./wezterm
  ];

  home.packages = with pkgs; [
    colima
    curl
    docker
    duf
    fd
    gnupg
    go
    gzip
    (
      google-cloud-sdk.withExtraComponents
      (with google-cloud-sdk.components; [
        gke-gcloud-auth-plugin
        gcloud-man-pages
      ])
    )
    httpie
    jq
    kubectl
    less
    nixpkgs-fmt
    nodejs_20
    pass
    pre-commit
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
  programs.bash.enableCompletion = false;

  programs.zellij = {
    enable = true;
  };
}
