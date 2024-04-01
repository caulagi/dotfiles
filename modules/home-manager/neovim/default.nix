{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.neovim.enable = true;
  home.file.".config/nvim/init.lua".text = builtins.readFile ./init.lua;
  home.file.".config/nvim/lua/plugins.lua".text = builtins.readFile ./plugins.lua;
}
