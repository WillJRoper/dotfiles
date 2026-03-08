# WezTerm Configuration

WezTerm is a GPU-accelerated terminal emulator with Lua-based configuration.

- Docs: https://wezfurlong.org/wezterm/
- Config reference: https://wezfurlong.org/wezterm/config/files.html
- Source: `home/dot_config/wezterm/wezterm.lua`
- Target: `~/.config/wezterm/wezterm.lua`

## Section Guide For `wezterm.lua`

- `wezterm.config_builder()`: creates a typed config table with better error reporting.
- appearance block:
  - `color_scheme = "Catppuccin Mocha"`
  - `font` / `font_size`
  - `enable_tab_bar = false` for a cleaner tmux-first layout
  - `window_decorations = "RESIZE"` to keep minimal chrome
  - `window_background_opacity = 0.8` for transparency
  - `default_cursor_style = "BlinkingBar"`
- behavior block:
  - `window_close_confirmation = "NeverPrompt"`
  - `adjust_window_size_when_changing_font_size = false`

## Why This Matches The Rest Of The Dotfiles

- WezTerm is intentionally minimal because tmux handles multiplexing and status workflow.
- Visual choices align with Starship/tmux colors and nerd-font-based glyph usage.

## Validation

After edits, test with:

```bash
wezterm start --always-new-process
```
