{
  config,
  pkgs,
  ...
}: {
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
    };
  };

  xdg.configFile."fish/completions/pass.fish".source = ./completions/password-store.fish;
}
