# 3. Install Software And Dotfiles

## Clone Without Applying

Initialize the repository without changing home-directory files:

```bash
chezmoi init https://github.com/WillJRoper/dotfiles.git
```

The repository is stored at `~/.local/share/chezmoi`. Managed source lives under
its `home/` directory because `.chezmoiroot` sets the source root.

## Install Core Software

Install packages required by managed configuration:

```bash
brew bundle --file="$HOME/.local/share/chezmoi/Brewfile"
```

This installs Bash, Chezmoi, development CLI tools, Node.js, uv, `age`, AWS CLI,
OpenCode, Docker Desktop, VS Code, terminal applications, Vorssaint, and the
arXiv MCP tool.

Optional compiler, scientific, presentation, Blender, and Gemini packages are
separate:

```bash
brew tap gromgit/fuse
brew trust --formula gromgit/fuse/sshfs-mac
brew bundle --file="$HOME/.local/share/chezmoi/Brewfile.optional"
```

Review `Brewfile.optional` first. Use project environments for software such as
HDF5 1.10 when Homebrew no longer supplies the required historical version.

## Preview Changes

Do not skip this step:

```bash
chezmoi status
chezmoi diff
chezmoi apply --dry-run --verbose
```

On a clean Mac, the preview should create managed files rather than replace
useful local configuration. If local files already exist, inspect each change.
Do not import shell profiles, OpenCode config, or application plists blindly;
they can contain credentials and private state.

To preserve a reviewed local file:

```bash
chezmoi add ~/.path-to-reviewed-config
git -C "$HOME/.local/share/chezmoi" diff
```

Remove credentials before importing anything.

## Apply

```bash
chezmoi apply
```

First application also installs ble.sh, tmux plugin manager, npm tools,
CodeGraph integration, Caveman, Cloudflare skills, VS Code extensions, and safe
Vorssaint preferences. It does not copy authentication state, clipboard history,
scratchpad content, or application caches.

## Configure Bash

Use Homebrew Bash as the login shell:

```bash
BREW_BASH="$(brew --prefix)/bin/bash"
grep -qxF "$BREW_BASH" /etc/shells || echo "$BREW_BASH" | sudo tee -a /etc/shells
chsh -s "$BREW_BASH"
```

Close and reopen the terminal, then confirm:

```bash
echo "$SHELL"
bash --version
command -v dotfiles-secrets-icloud
```

Inside tmux, press `Ctrl-a` followed by `I` if plugins have not appeared.

Continue to [`04_restore_secrets_and_auth.md`](04_restore_secrets_and_auth.md).
