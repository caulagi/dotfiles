{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.neovim.enable = true;

  home.file.".config/nvim/init.lua".text = builtins.readFile ./init.lua;
  home.file.".config/nvim/lua/config/lazy.lua".text = builtins.readFile ./lua/config/lazy.lua;
  home.file.".config/nvim/lua/plugins/custom.lua".text = builtins.readFile ./lua/plugins/custom.lua;
  home.file.".config/nvim/README.md".text = builtins.readFile ./README.md;
}
