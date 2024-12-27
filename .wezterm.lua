local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

config.front_end = "WebGpu"
config.max_fps = 120

config.keys = {
  {
    key = 'F11',
    action = wezterm.action.ToggleFullScreen,
  }
}

config.default_prog = {"wsl.exe", "--cd", "~", "--", "zsh"}
config.font = wezterm.font_with_fallback {
  "BerkeleyMono Nerd Font",
  "Symbol Nerd Font",
}
config.font_size = 10
config.allow_square_glyphs_to_overflow_width = "Always"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.default_cursor_style = 'SteadyBar'
config.colors = {
  cursor_bg = "#ffb6c1",
  cursor_border = "#ffb6c1",
}
-- https://wezfurlong.org/wezterm/config/lua/config/term.html
config.term = "wezterm"

return config