local wezterm = require("wezterm")

return {
  font = wezterm.font("HackGen35Nerd Console"),
  use_ime = true, -- IME動かすやつ
  font_size = 18.0,
  color_scheme = "nightfox",
  -- hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
  -- default_prog = { "/opt/homebrew/bin/fish", "-l", "-c", 'zellij' },
  -- tab bar
  use_fancy_tab_bar = false,
  leader = { key = "q", mods = "CTRL", timeout_milliseconds = 1000 },
  keys = {
    { key = "l", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
    { key = "h", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
  },
  colors = {
    cursor_bg = "#c6c8d1",
    tab_bar = {
      background = "#1b1f2f",

      active_tab = {
        bg_color = "#444b71",
        fg_color = "#c6c8d1",
        intensity = "Normal",
        underline = "None",
        italic = false,
        strikethrough = false,
      },

      inactive_tab = {
        bg_color = "#282d3e",
        fg_color = "#c6c8d1",
        intensity = "Normal",
        underline = "None",
        italic = false,
        strikethrough = false,
      },

      inactive_tab_hover = {
        bg_color = "#1b1f2f",
        fg_color = "#c6c8d1",
        intensity = "Normal",
        underline = "None",
        italic = true,
        strikethrough = false,
      },

      new_tab = {
        bg_color = "#1b1f2f",
        fg_color = "#c6c8d1",
        italic = false
      },

      new_tab_hover = {
        bg_color = "#444b71",
        fg_color = "#c6c8d1",
        italic = false
      },
    }
  },
}
