{
  config,
  pkgs,
  ...
}: {
  environment = {
    variables = {
      EDITOR = "nvim";
      HOMEBREW_NO_GITHUB_API = "1";
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
  };
}
