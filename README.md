# Dotfiles

Personal shell, terminal, editor, and developer-tool configuration managed with
[Chezmoi](https://www.chezmoi.io/). The configuration is macOS-first, with
partial Linux/HPC support.

## Install

### macOS

Install Homebrew if needed:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install Chezmoi and initialize this repository:

```bash
brew install chezmoi
chezmoi init https://github.com/WillJRoper/dotfiles.git
```

Install the core packages used by the managed configuration:

```bash
brew bundle --file="$HOME/.local/share/chezmoi/Brewfile"
```

Preview and apply the dotfiles:

```bash
chezmoi diff
chezmoi apply
```

Chezmoi installs ble.sh and the tmux plugin manager through run-once scripts.
After starting tmux, press `Ctrl-a` followed by `I` to install the configured
tmux plugins.

### Optional Packages

`Brewfile.optional` contains scientific, compiler, HPC, presentation, and other
heavier tools that are not required by the core configuration. Review it before
installing:

```bash
brew tap gromgit/fuse
brew trust --formula gromgit/fuse/sshfs-mac
brew bundle --file="$HOME/.local/share/chezmoi/Brewfile.optional"
```

### Linux And HPC

Install Chezmoi using the appropriate package manager or the official installer:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)"
chezmoi init https://github.com/WillJRoper/dotfiles.git
chezmoi diff
chezmoi apply
```

The Homebrew manifests and some shell helpers are macOS-specific. Always review
the diff before applying on Linux or an HPC system.

## Shell

The primary shell configuration targets Homebrew Bash. To use it as the login
shell on macOS:

```bash
BREW_BASH="$(brew --prefix)/bin/bash"
grep -qxF "$BREW_BASH" /etc/shells || echo "$BREW_BASH" | sudo tee -a /etc/shells
chsh -s "$BREW_BASH"
```

A minimal `.zshrc` keeps Atuin available when using the macOS default shell.

Machine-local environment variables and credentials can be placed in
`~/.config/dotfiles/secrets.sh`. This file is intentionally not managed:

```bash
mkdir -p "$HOME/.config/dotfiles"
touch "$HOME/.config/dotfiles/secrets.sh"
chmod 600 "$HOME/.config/dotfiles/secrets.sh"
```

## Included Configuration

- Bash aliases, functions, prompt, history, completion, and vi-style editing
- Minimal zsh initialization
- Git, Git LFS, Delta, GitHub CLI, and global ignore rules
- Neovim configuration with a pinned plugin lockfile
- tmux, TPM, session persistence, and sesh integration
- Starship, WezTerm, Atuin, btop, neofetch, Television, and The Fuck
- OpenCode agents and MCP configuration
- VS Code settings and keybindings
- Python environment helpers and utility scripts

Chezmoi maps files beneath `home/` to the home directory. For example,
`home/dot_config/nvim` becomes `~/.config/nvim`. The repository-level
`.chezmoiroot` declares `home/` as the Chezmoi source-state root.

## Update

Pull and apply repository updates:

```bash
chezmoi update
```

Review local differences:

```bash
chezmoi status
chezmoi diff
```

Edit managed source state with `chezmoi edit <target>` or work directly in the
directory returned by `chezmoi cd`. Commit and push source changes normally.

## Authentication

Authentication state is not committed. Configure tools separately as needed:

```bash
gh auth login
git lfs install
atuin login
```

Git commit signing is enabled automatically when `~/.ssh/ghub_key.pub` exists.

## Additional Documentation

- [`docs/MIGRATION_CHECKLIST.md`](docs/MIGRATION_CHECKLIST.md): transferring
  credentials, data, and unmanaged state between machines
- [`docs/APPLICATION_INVENTORY.md`](docs/APPLICATION_INVENTORY.md): audited
  application inventory from the previous workstation
- Component-specific documentation is stored alongside configuration under
  `home/dot_config/`
