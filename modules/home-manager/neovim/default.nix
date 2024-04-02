{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.neovim.enable = true;

  home.file.".config/nvim/init.lua".text = builtins.readFile ./init.lua;
  home.file.".config/nvim/lua/config/autocmds.lua".text = builtins.readFile ./lua/config/autocmds.lua;
  home.file.".config/nvim/lua/config/keymaps.lua".text = builtins.readFile ./lua/config/keymaps.lua;
  home.file.".config/nvim/lua/config/lazy.lua".text = builtins.readFile ./lua/config/lazy.lua;
  home.file.".config/nvim/lua/config/options.lua".text = builtins.readFile ./lua/config/options.lua;
  home.file.".config/nvim/lua/plugins/custom.lua".text = builtins.readFile ./lua/plugins/custom.lua;
}
