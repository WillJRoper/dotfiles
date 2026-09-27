# 3. Install Software And Dotfiles

## Clone Without Applying

Initialize the repository without changing home-directory files:

```bash
chezmoi init https://github.com/WillJRoper/dotfiles.git
```

The repository is stored at `~/.local/share/chezmoi`. Managed source lives under
its `home/` directory because `.chezmoiroot` sets the source root.

## Optional Agent-Guided Setup

To let OpenCode guide the remaining phases, install only its CLI first:

```bash
brew install anomalyco/tap/opencode
opencode "$HOME/.local/share/chezmoi"
```

Complete provider authentication in the interactive interface, then send:

```text
Read setup/AGENT_SETUP_PROMPT.md and follow it exactly.
```

Keep the session interactive and do not use `--auto`. The prompt requires clear
human handoffs for secrets, authentication, passphrases, system permissions,
external portals, and approval before applying changes. Continue below instead
for fully manual setup.

## Install Core Software

Install packages required by managed configuration:

```bash
brew bundle --file="$HOME/.local/share/chezmoi/Brewfile"
```

This installs Bash, Chezmoi, development CLI tools, Node.js, uv, `age`, AWS CLI,
OpenCode, Docker Desktop, VS Code, terminal applications, Vorssaint, the
reviewed core desktop apps in `docs/APPLICATION_INVENTORY.md`, and the arXiv MCP
tool.

Optional compiler, scientific, presentation, Blender, and Gemini packages are
separate:

```bash
brew tap gromgit/fuse
brew trust --formula gromgit/fuse/sshfs-mac
brew bundle --file="$HOME/.local/share/chezmoi/Brewfile.optional"
```

Review `Brewfile.optional` first. Use project environments for software such as
HDF5 1.10 when Homebrew no longer supplies the required historical version.

## Configure Chezmoi Encryption

Find the `Chezmoi age identity` entry in Apple Passwords (`dotfiles` username,
`chezmoi` website). Restore its password, the complete `AGE-SECRET-KEY-...`
line, before applying encrypted files:

```bash
mkdir -p "$HOME/.config/chezmoi"
nvim "$HOME/.config/chezmoi/key.txt"
chmod 600 "$HOME/.config/chezmoi/key.txt"
```

Verify the restored identity matches this repository's public recipient:

```bash
test "$(age-keygen -y "$HOME/.config/chezmoi/key.txt")" = \
    "age1pmsftlzm44lr74upjwz64jax5x724x7nwjfwmhg8mvs4laaeaars6agxhk" \
    && echo "Age identity verified"
```

The repository's Chezmoi config template supplies the encryption settings. Keep
the age identity file out of Git and backed up in Apple Passwords.

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

Confirm the managed secrets helper is available:

```bash
command -v dotfiles-secrets-icloud
```

Inside tmux, press `Ctrl-a` followed by `I` if plugins have not appeared.

Continue to [`04_restore_secrets_and_auth.md`](04_restore_secrets_and_auth.md).
