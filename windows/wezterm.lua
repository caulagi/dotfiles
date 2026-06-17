-- Windows-side WezTerm config.
-- Mirrors the (non-WSL) Nix module modules/home-manager/wezterm/default.nix.
-- WezTerm runs on Windows and hosts the WSL session, so this file -- not the
-- one inside the distro -- is what takes effect when launching WSL.
--
-- Installed to %USERPROFILE%\.wezterm.lua by windows/install-wezterm.ps1.
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Open straight into the Ubuntu WSL distro instead of a Windows shell.
config.default_domain = "WSL:Ubuntu"

config.color_scheme = "Gruvbox dark, medium (base16)"
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 13
config.audible_bell = "Disabled"
config.scrollback_lines = 100000
config.window_frame = {
	font_size = 13.0,
}
config.send_composed_key_when_left_alt_is_pressed = true

return config
