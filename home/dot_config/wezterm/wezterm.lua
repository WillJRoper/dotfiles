-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- ===== Apearence =====

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"

-- Set the font
config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 12.5

-- Disbale the tab bar
config.enable_tab_bar = false

-- A minimal window (no edges == zen)
config.window_decorations = "RESIZE"

-- Sweet, sweet transparency
config.window_background_opacity = 0.8

-- Don't resize the window when changing font size
config.adjust_window_size_when_changing_font_size = false

-- Cursor style
config.default_cursor_style = "BlinkingBar"

-- ===== General Functionality ======

-- Don't prompt when closing
config.window_close_confirmation = "NeverPrompt"

return config
