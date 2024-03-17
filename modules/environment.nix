{
  config,
  pkgs,
  ...
}: {
  environment = {
    variables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      EDITOR = "nvim";
      HOMEBREW_NO_GITHUB_API = "1";
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
  };
}
