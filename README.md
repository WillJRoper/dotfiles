# Dotfiles

Personal macOS-first shell, terminal, editor, and developer-tool configuration
managed with [Chezmoi](https://www.chezmoi.io/). Linux and HPC hosts receive a
smaller compatible subset.

## New Mac Setup

Follow these guides in order. They assume a clean macOS installation without an
iCloud backup and keep the current Mac available during migration.

1. [`setup/01_prepare_current_mac.md`](setup/01_prepare_current_mac.md)
2. [`setup/02_bootstrap_macos.md`](setup/02_bootstrap_macos.md)
3. [`setup/03_install_dotfiles.md`](setup/03_install_dotfiles.md)
4. [`setup/04_restore_secrets_and_auth.md`](setup/04_restore_secrets_and_auth.md)
5. [`setup/05_restore_apps_and_data.md`](setup/05_restore_apps_and_data.md)
6. [`setup/06_verify_setup.md`](setup/06_verify_setup.md)

Do not skip preview, secret rotation, or final verification steps.

## Managed Configuration

- Bash aliases, functions, prompt, completion, history, and vi-style editing
- Minimal zsh fallback configuration
- Git, Git LFS, Delta, GitHub CLI defaults, and global ignore rules
- Neovim configuration and pinned plugin lockfile
- tmux, TPM, session persistence, and sesh integration
- Starship, WezTerm, Atuin, btop, neofetch, Television, and The Fuck
- OpenCode agents, MCP servers, Cloudflare skills, Caveman, and Ponytail
- VS Code settings, keybindings, and reviewed extensions
- Safe Vorssaint preferences
- Encrypted SSH config; private SSH keys remain machine-local
- Encrypted iCloud transfer helper for machine-local secrets
- Python environment helpers and utility scripts

Machine-local credentials live in `~/.config/dotfiles/secrets.sh`. This file is
never managed by Chezmoi or Git.

## Repository Layout

- `home/`: Chezmoi source state mapped into the home directory
- `Brewfile`: core software required by managed configuration
- `Brewfile.optional`: opt-in scientific, compiler, and specialist software
- `setup/`: ordered new-Mac setup instructions
- `docs/`: audit records, migration notes, and application inventory

## Updating An Existing Machine

Fetch and preview before applying:

```bash
chezmoi git pull -- --ff-only
chezmoi status
chezmoi diff
chezmoi apply --dry-run --verbose
chezmoi apply
```

Use `chezmoi edit <target>` to change managed files, or edit the directory
returned by `chezmoi source-path`. Never force-apply over unexplained local
changes.

## Linux And HPC

Install Chezmoi with the platform package manager or official installer, then
preview before applying:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)"
chezmoi init https://github.com/WillJRoper/dotfiles.git
chezmoi diff
chezmoi apply
```

Homebrew manifests and macOS application scripts are macOS-specific.

## Reference

- [`docs/MIGRATION_CHECKLIST.md`](docs/MIGRATION_CHECKLIST.md)
- [`docs/APPLICATION_INVENTORY.md`](docs/APPLICATION_INVENTORY.md)
- Component documentation under `home/dot_config/`
