local wezterm = require("wezterm")

return {
  font = wezterm.font("HackGen35Nerd Console"),
  use_ime = true, -- IME動かすやつ
  font_size = 18.0,
  color_scheme = "nightfox",
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
  default_prog = { "/opt/homebrew/bin/fish", "-l", "-c", 'zellij' },
}

