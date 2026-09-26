# 6. Verify The New Mac

Do not retire or erase the current Mac until this phase passes.

## Dotfiles

```bash
chezmoi status
chezmoi diff
```

Expected output is empty. Investigate differences rather than forcing an apply.

## Packages And Tools

```bash
brew bundle check --file="$HOME/.local/share/chezmoi/Brewfile"
npm ls --global --depth=0
uv tool list
gh extension list
command -v bash nvim tmux opencode codegraph age
```

If optional packages were installed:

```bash
brew bundle check --file="$HOME/.local/share/chezmoi/Brewfile.optional"
```

## Shell And Secrets

```bash
echo "$SHELL"
dotfiles-secrets-icloud status
stat -f '%Sp %N' "$HOME/.config/dotfiles" "$HOME/.config/dotfiles/secrets.sh"
bash -n "$HOME/.bash_profile" "$HOME/.bashrc" "$HOME/.config/dotfiles/secrets.sh"
```

Expected shell is Homebrew Bash. Both local and iCloud secret status values
should be `present`.

## Authentication

```bash
gh auth status
aws sts get-caller-identity --profile agent-toolkit
git lfs env
```

Confirm Atuin sync, Cloudflare MCP OAuth, Docker login, and any required SSH
connections.

## Launch Tests

Open and exercise:

- Neovim
- tmux and sesh
- WezTerm and iTerm2
- VS Code
- Vorssaint
- OpenCode and Claude Code
- Docker Desktop
- Required research and licensed applications

Verify important projects build or run from clean environments.

## Final Check

- Dotfiles and package checks pass.
- Secrets and authentication work without values stored in Git.
- Projects and personal data are available.
- Required applications launch.
- Current Mac remains available until several days of normal work complete.

Setup is complete.
