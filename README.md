# Dotfiles

Personal macOS-first development environment managed with
[Chezmoi](https://www.chezmoi.io/). Linux/HPC support is partial: editor config
is usable there, but package installation and some shell helpers are macOS-specific.

## Before Migrating

The new laptop can only receive changes that are committed and pushed. On the
old laptop, review `git status`, remove secrets, commit the intended changes,
and push before beginning. Never commit API keys or private keys.

Plaintext Synthesizer credentials previously existed in this repository. Rotate
them before migration; deleting them from the current file does not remove them
from Git history.

## New Mac Setup

### 1. Install Apple Tools And Homebrew

```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow Homebrew's printed `shellenv` instruction, then install Chezmoi:

```bash
brew install chezmoi
```

### 2. Fetch The Repository

Initialize without applying yet so packages can be installed first:

```bash
chezmoi init https://github.com/WillJRoper/dotfiles.git
```

The repository is cloned below `~/.local/share/chezmoi`. Install the core tools
used directly by the managed configs:

```bash
brew bundle --file="$HOME/.local/share/chezmoi/Brewfile"
```

`Brewfile.optional` records the heavier compiler, scientific, presentation, and
specialized tools installed on the old workstation. Review it before opting in:

```bash
brew tap gromgit/fuse
brew trust --formula gromgit/fuse/sshfs-mac  # required by Homebrew 6
brew bundle --file="$HOME/.local/share/chezmoi/Brewfile.optional"
```

This split avoids reinstalling every historical package while retaining a
record of explicitly installed Homebrew software. Homebrew resolves transitive
dependencies automatically.

### 3. Preview And Apply Config

```bash
chezmoi diff
chezmoi apply
```

Chezmoi also installs ble.sh and the tmux plugin manager. In tmux, press the
prefix (`Ctrl-a`) followed by `I` to install the configured plugins.

### 4. Select Homebrew Bash

macOS ships an old Bash and defaults to zsh. Add the Homebrew Bash path once,
then select it as the login shell:

```bash
BREW_BASH="$(brew --prefix)/bin/bash"
grep -qxF "$BREW_BASH" /etc/shells || echo "$BREW_BASH" | sudo tee -a /etc/shells
chsh -s "$BREW_BASH"
```

Log out and back in after changing the login shell. The managed `.zshrc` keeps
Atuin usable until that change takes effect.

### 5. Restore Identity And Authentication

Restore credentials through their own secure mechanisms, not Git:

```bash
gh auth login
git lfs install
atuin login
```

The Git config signs commits only when `~/.ssh/ghub_key.pub` exists. Restore the
existing SSH key securely or generate a new signing/authentication key, add it
to GitHub, and run `chezmoi apply` again. Do not copy private keys through this
repository.

Machine-local environment variables can be loaded from:

```bash
mkdir -p "$HOME/.config/dotfiles"
touch "$HOME/.config/dotfiles/secrets.sh"
chmod 600 "$HOME/.config/dotfiles/secrets.sh"
```

Add `export NAME="value"` lines there. The file is intentionally unmanaged.

### 6. Finish Application Setup

Sign into applications such as GitHub, Atuin, Docker, Warp, VS Code, OpenCode,
cloud storage, browsers, and AI tools. Restore SSH/GPG material and project data
from an encrypted backup or password manager. See
[`docs/MIGRATION_CHECKLIST.md`](docs/MIGRATION_CHECKLIST.md) for the complete
manual checklist, [`docs/APPLICATION_INVENTORY.md`](docs/APPLICATION_INVENTORY.md)
for the old laptop's app inventory, and the audited home-directory gaps.

### 7. Verify

```bash
brew bundle check --file="$HOME/.local/share/chezmoi/Brewfile"
chezmoi doctor
chezmoi status
bash -l
nvim --headless '+Lazy! sync' +qa
tmux new-session -d -s setup-check && tmux kill-session -t setup-check
```

## Managed Configuration

- Bash and minimal zsh startup config
- Git, GitHub CLI, and global ignore rules
- Neovim, tmux, WezTerm, Starship, Atuin, btop, sesh, and Television
- OpenCode agents and MCP configuration
- VS Code user settings and keybindings
- Utility scripts

Chezmoi maps `home/dot_config/nvim` to `~/.config/nvim`. The `.chezmoiroot`
file makes `home/` the source-state root while package manifests remain at the
repository root.

## Updating

```bash
chezmoi update
```

To edit managed state, use `chezmoi cd`, edit the source file, review
`chezmoi diff`, then commit and push from the source repository.

## HPC Notes

Chezmoi records hostname/scheduler-based HPC detection in its template data,
while Neovim performs its own runtime HPC detection. Do not assume every macOS
shell helper is portable to a cluster. Review changes with `chezmoi diff`
before applying on Linux/HPC systems.
