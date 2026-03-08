# XDG Configs

This directory contains the dotfiles that are installed under `~/.config/`.

- Repo source: `home/dot_config/...`
- Installed target: `~/.config/...`

## How To Read This Tree

Each subdirectory has its own README that explains:

- what the tool does,
- which config file controls behavior,
- what each major config section means,
- and what should or should not be committed.

## Tool Index

- `nvim/`: Neovim editor config (LSP, plugins, keymaps)
- `starship/`: shell prompt rendering and context modules
- `tmux/`: terminal multiplexer behavior and plugin setup
- `wezterm/`: terminal emulator appearance and defaults
- `atuin/`: shell history search and optional sync
- `btop/`: terminal system monitor layout and metrics
- `neofetch/`: shell startup system summary output
- `thefuck/`: command correction behavior
- `gh/`: GitHub CLI defaults (non-secret)
- `opencode/`: OpenCode MCP/tools/agent configuration

## Commit Rules For This Directory

- Commit: deterministic preferences and workflows.
- Do not commit: auth/session/runtime files (for example `gh/hosts.yml`, caches, lock/runtime artifacts).
- Use `*.tmpl` when values differ between machines (paths, host-specific settings).
