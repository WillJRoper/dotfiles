# Neofetch Configuration

Neofetch prints a formatted system summary in the terminal (OS, shell, CPU, memory, etc.).

- Project: https://github.com/dylanaraps/neofetch
- Customization wiki: https://github.com/dylanaraps/neofetch/wiki/Customizing-Info
- Source: `home/dot_config/neofetch/config.conf`
- Target: `~/.config/neofetch/config.conf`

## How This File Is Structured

- `print_info()` (top of file): defines which fields are shown and in what order.
- Feature blocks below: each category controls formatting for one metric family (`Kernel`, `Distro`, `Memory`, `CPU`, `GPU`, `Disk`, etc.).
- Styling blocks: separators, colors, bars, ASCII/logo settings.

## What This Repo's Config Emphasizes

- `print_info()` shows host, kernel, packages, shell, display, terminal, CPU/GPU, memory.
- `kernel_shorthand="on"` and `uptime_shorthand="on"` keep output compact.
- `package_managers="on"` shows package manager source next to counts.
- `memory_unit="mib"` and `memory_percent="off"` prefer explicit absolute memory values.

## Practical Editing Tips

- Add/remove lines in `print_info()` first; this changes what appears immediately.
- Keep platform-specific fields commented unless you use them regularly.
- Test with `neofetch` after edits to confirm formatting alignment in your terminal font.
