# Config Directory

This directory contains Chezmoi-managed XDG config sources.

- Source in repo: `home/dot_config/...`
- Destination on machine: `~/.config/...`

## Managed Components

- `nvim/`: Neovim configuration (fully documented in nested READMEs)
- `starship/`: shell prompt configuration
- `tmux/`: tmux configuration
- `wezterm/`: WezTerm terminal configuration
- `atuin/`: shell history search/sync configuration
- `btop/`: system monitor configuration
- `neofetch/`: system information output configuration
- `thefuck/`: command correction tool settings
- `gh/`: GitHub CLI defaults (non-secret config only)
- `opencode/`: OpenCode settings and custom agent definitions

## Portability Notes

- Files with secrets or machine-bound auth are not tracked (for example `gh/hosts.yml`).
- Generated runtime state is excluded from version control.
- Paths that vary by machine should use Chezmoi templates (`*.tmpl`) where needed.
