local wezterm = require 'wezterm';

return {
  color_scheme = "Gruvbox Dark",
  font = wezterm.font("Fira Code"),
  font_size = 14,
  audible_bell = "Disabled",
  scrollback_lines = 100000,
  window_frame = {
    font_size = 14.0,
  },
  -- keys = {
  --   {key="+", mods="CTRL", action="IncreaseFontSize"},
  --   {key="-", mods="CTRL", action="DecreaseFontSize"},
  -- },
  send_composed_key_when_left_alt_is_pressed = true,
}
