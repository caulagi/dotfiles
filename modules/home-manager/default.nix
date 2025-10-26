# https://nix-community.github.io/home-manager/options.html
{pkgs, ...}: {
  home.stateVersion = "23.11";

  imports = [
    ./bat
    ./fish
    ./git
    ./lazygit
    ./neovim
    ./password-store
    ./python
    ./starship
    ./wezterm
  ];

  home.packages = with pkgs; [
    colima
    curl
    delta
    direnv
    docker
    docker-buildx
    duf
    fd
    gh
    gnupg
    go
    gzip
    (
      google-cloud-sdk.withExtraComponents
      (with google-cloud-sdk.components; [
        gke-gcloud-auth-plugin
        gcloud-man-pages
        cloud-sql-proxy
      ])
    )
    httpie
    jq
    kubectl
    lazygit
    less
    neovim-remote
    nixpkgs-fmt
    nodejs_20
    pre-commit
    ripgrep
    shellcheck
    terraform
    watch
    wget
  ];
  home.sessionVariables = {
    HISTFILE = "$XDG_DATA_HOME/bash_history";
    PAGER = "less";
    CLICLOLOR = 1;
    PATH = "$PATH:$HOME/go/bin";
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
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

  programs.direnv = {
    # don't need to enable explicitly for fish since fish automatically loads direnv package
    enable = true;
    nix-direnv.enable = true;
  };
}
