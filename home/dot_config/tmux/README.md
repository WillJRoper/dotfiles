# Tmux Configuration

tmux is a terminal multiplexer: persistent sessions, multiple panes/windows, and remote-friendly workflows.

- Docs: https://github.com/tmux/tmux/wiki
- Source: `home/dot_config/tmux/tmux.conf`
- Target: `~/.config/tmux/tmux.conf`

## Section Guide For `tmux.conf`

- terminal capabilities (`default-terminal`, `terminal-overrides`): enables truecolor/256color compatibility.
- prefix remap: changes leader from `Ctrl-b` to `Ctrl-a`.
- split/navigation bindings: `|` and `-` splits, vim-like resize binds (`h/j/k/l`).
- quality-of-life behavior: mouse mode, pane/window index starts at 1, renumber windows on close.
- copy/input behavior: vi copy mode and clipboard integration (`set-clipboard on`).
- plugin manager section: TPM path and plugin list.
- plugin-specific options: resurrect/continuum persistence and Catppuccin status line formatting.

## Plugins In Use

- TPM: `tmux-plugins/tpm` (plugin manager)
- `christoomey/vim-tmux-navigator` (seamless vim/tmux pane movement)
- `tmux-plugins/tmux-resurrect` (session restore)
- `tmux-plugins/tmux-continuum` (autosave/auto-restore)
- `catppuccin/tmux` (theme)

## Operational Commands

- Reload config in tmux: prefix then `r`.
- First-time plugin install: prefix then `I` (capital i).
- Restore session (if needed): prefix then `Ctrl-s` / plugin-defined restore command.
