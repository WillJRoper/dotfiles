# Atuin Configuration

Atuin is an improved shell history engine with fuzzy search, context-aware filtering, and optional encrypted sync.

- Website: https://atuin.sh
- Docs: https://docs.atuin.sh
- Source: `home/dot_config/atuin/config.toml`
- Target: `~/.config/atuin/config.toml`

## What This Config Controls

- `enter_accept = true`: selecting a history result executes immediately on Enter.
- `[stats]`: controls how Atuin groups and reports command usage statistics.
- `[keys]`: key-navigation behavior inside Atuin's TUI.

Most other lines are commented defaults from Atuin's generated template. They are intentionally kept as inline reference documentation.

## Important Sections In `config.toml`

- `search_mode` and `filter_mode` (currently commented): choose matching strategy and history scope.
- `history_filter` / `cwd_filter` (commented): regex-based redaction for sensitive commands/directories.
- `secrets_filter` (commented, default enabled): built-in token/secret detection.
- sync settings (`auto_sync`, `sync_address`, `sync_frequency`, commented): enable only if you want cross-machine history sync.

## Operational Notes

- Atuin shell hooks are initialized from `~/.bashrc` (this repo's `home/dot_bashrc`).
- If keybindings change, open a new shell or re-source `~/.bashrc`.
- Do not commit Atuin session/key state from `~/.local/share/atuin/`.
