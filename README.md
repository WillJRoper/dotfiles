# Dotfiles

Personal macOS-first shell, terminal, editor, and developer-tool configuration
managed with [Chezmoi](https://www.chezmoi.io/). Linux and HPC hosts receive a
smaller compatible subset.

## Before Moving To A New Mac

The new laptop clones the remote repository, not unpushed local commits. On the
existing laptop, confirm the source state is committed and pushed:

```bash
git -C "$HOME/dotfiles" status
git -C "$HOME/dotfiles" log --oneline origin/main..HEAD
git -C "$HOME/dotfiles" push
```

Never copy authentication databases or credentials into this repository. Move
SSH keys, GPG keys, cloud credentials, and password-manager data through an
encrypted channel. Sync research projects and other user data separately.

## New Mac Setup

These steps assume a clean macOS installation without an iCloud backup.

### 1. Install System Prerequisites

Install Xcode from the Mac App Store when needed, then install its command-line
tools:

```bash
xcode-select --install
```

Install Homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the Homebrew installer prompt to add `brew shellenv` to the temporary
shell, then install Chezmoi:

```bash
brew install chezmoi
```

### 2. Clone The Dotfiles Without Applying Them

Initialize the repository first, but do not use `--apply`:

```bash
chezmoi init https://github.com/WillJRoper/dotfiles.git
```

The repository is stored at `~/.local/share/chezmoi`; managed source files live
under its `home/` directory because `.chezmoiroot` sets that source root.

### 3. Install Core Software

Install software required by managed configuration:

```bash
brew bundle --file="$HOME/.local/share/chezmoi/Brewfile"
```

This includes shell/editor tools, Docker Desktop, terminals, VS Code, Vorssaint,
OpenCode, AWS CLI, Node.js, uv, and the arXiv MCP tool.

Heavy compilers, scientific libraries, presentation tools, Blender, and Gemini
CLI are optional:

```bash
brew tap gromgit/fuse
brew trust --formula gromgit/fuse/sshfs-mac
brew bundle --file="$HOME/.local/share/chezmoi/Brewfile.optional"
```

Review `Brewfile.optional` before running it. In particular, use project-level
environments when an old project requires HDF5 1.10 rather than installing a
retired global Homebrew formula.

### 4. Preview Before Applying

Chezmoi must not silently replace useful local changes. On a clean Mac the diff
should consist only of files this repository intends to create:

```bash
chezmoi status
chezmoi diff
chezmoi apply --dry-run --verbose
```

If configuring a Mac that already has local dotfiles, stop and inspect every
change. Import a wanted local version only after removing credentials:

```bash
chezmoi add ~/.path-to-reviewed-config
git -C "$HOME/.local/share/chezmoi" diff
```

Do not import `~/.bash_profile`, OpenCode config, or application plists blindly;
they can contain credentials, machine paths, bookmarks, or private state.

### 5. Apply Managed Configuration

Apply after reviewing the preview:

```bash
chezmoi apply
```

First application also:

- installs ble.sh and tmux plugin manager;
- installs pinned global npm tools;
- installs Caveman for Claude Code and OpenCode;
- installs Cloudflare agent skills;
- installs the reviewed VS Code extension list;
- applies safe Vorssaint preferences without copying clipboard or scratchpad
  content;
- creates standard project and script directories.

Run `chezmoi diff` again afterwards. Expected output is empty. Restart OpenCode
after configuration changes because it loads configuration only at startup.

### 6. Configure The Login Shell

Use Homebrew Bash as the login shell:

```bash
BREW_BASH="$(brew --prefix)/bin/bash"
grep -qxF "$BREW_BASH" /etc/shells || echo "$BREW_BASH" | sudo tee -a /etc/shells
chsh -s "$BREW_BASH"
```

Open a new terminal. Inside tmux, press `Ctrl-a` followed by `I` if its plugins
have not appeared.

### 7. Restore Secrets And Authentication

Create the intentionally unmanaged secrets file:

```bash
mkdir -p "$HOME/.config/dotfiles"
touch "$HOME/.config/dotfiles/secrets.sh"
chmod 600 "$HOME/.config/dotfiles/secrets.sh"
```

Populate it from a password manager with only variables needed on this machine,
including Obsidian and NASA ADS values when those MCP servers are used:

```bash
export OBSIDIAN_API_KEY="..."
export OBSIDIAN_HOST="..."
export OBSIDIAN_PORT="..."
export ADS_API_TOKEN="..."
```

Authenticate tools independently:

```bash
gh auth login
git lfs install
atuin login
aws login --profile agent-toolkit
```

Open OpenCode once and complete OAuth for enabled Cloudflare MCP servers. Restore
SSH private keys and `~/.ssh/config` through an encrypted channel. Restore GPG,
Docker, and other cloud credentials separately.

The installed GitHub Copilot extension is not automated because `gh extension`
installation is best performed after GitHub authentication:

```bash
gh extension install github/gh-copilot
```

### 8. Restore Data And Manual Applications

Restore project repositories, `~/SecondBrain`, `~/org`, datasets, and documents
from their authoritative remotes or encrypted backups. Do not copy virtual
environments when lockfiles can recreate them.

Use `docs/APPLICATION_INVENTORY.md` to review Mac App Store, licensed, and
vendor-managed software. Browser profiles should come from browser sync or an
encrypted profile backup.

The following configuration is deliberately not migrated by this repository:

- Doom Emacs and generated `~/.emacs.d` state;
- Warp settings and themes;
- Codex configuration and authentication;
- Gemini configuration and authentication;
- clipboard history, Vorssaint shelf files, and scratchpad contents;
- application caches, histories, sessions, and OAuth databases.

### 9. Verify The Installation

```bash
chezmoi status
chezmoi diff
brew bundle check --file="$HOME/.local/share/chezmoi/Brewfile"
npm ls --global --depth=0
uv tool list
gh extension list
```

Also launch Neovim, VS Code, tmux, WezTerm, Vorssaint, OpenCode, Docker Desktop,
and any manually installed research applications.

## Managed Configuration

- Bash aliases, functions, prompt, completion, history, and vi-style editing
- Minimal zsh initialization
- Git, Git LFS, Delta, GitHub CLI defaults, and global ignore rules
- Neovim configuration and pinned plugin lockfile
- tmux, TPM, session persistence, and sesh integration
- Starship, WezTerm, Atuin, btop, neofetch, Television, and The Fuck
- OpenCode agents, MCP servers, Cloudflare skills, Caveman, and Ponytail
- VS Code settings, keybindings, and reviewed extensions
- Safe Vorssaint preferences
- Python environment helpers and utility scripts

Machine-local credentials belong in `~/.config/dotfiles/secrets.sh`, never in
managed source.

## Updating An Existing Machine

Fetch changes and preview before applying:

```bash
chezmoi git pull -- --ff-only
chezmoi status
chezmoi diff
chezmoi apply --dry-run --verbose
chezmoi apply
```

Use `chezmoi edit <target>` to change managed files, or edit the source directory
returned by `chezmoi source-path`. Commit and push from the repository root.

## Linux And HPC

Install Chezmoi with the platform package manager or official installer:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)"
chezmoi init https://github.com/WillJRoper/dotfiles.git
chezmoi diff
chezmoi apply
```

Homebrew manifests and macOS application scripts are macOS-specific. Always
review the diff before applying on Linux or HPC systems.

## Additional Documentation

- [`docs/MIGRATION_CHECKLIST.md`](docs/MIGRATION_CHECKLIST.md): secure material,
  data transfer, and remaining manual checks
- [`docs/APPLICATION_INVENTORY.md`](docs/APPLICATION_INVENTORY.md): application
  census and reinstall decisions
- Component-specific documentation under `home/dot_config/`
