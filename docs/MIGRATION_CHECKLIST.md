# New Laptop Migration Checklist

This file records the state that should not be blindly committed to the
dotfiles repository and the useful configuration found during the August 2026
home-directory audit.

## Secure Material

- Rotate the Synthesizer credentials that were previously committed.
- Rotate the R2 access credentials currently present in the live
  `~/.bash_profile`; they are not retained in the managed source.
- Restore SSH private keys and `~/.ssh/config` through an encrypted channel.
- Restore GPG keys separately if they are still used.
- Authenticate GitHub CLI with `gh auth login`; never copy `gh/hosts.yml` here.
- Authenticate Atuin with `atuin login` and sync history if wanted.
- Re-authenticate OpenCode, Claude, Codex, Gemini, cloud CLIs, and MCP services.
- Recreate `~/.config/dotfiles/secrets.sh`, set mode `600`, and add required API
  variables from a password manager.
- Restore AWS credentials, Docker credentials, and similar files separately.

## Data And Applications

- Confirm iCloud/Dropbox/OneDrive/Box data is fully synced before retiring the
  old laptop.
- Back up research projects, `~/SecondBrain`, `~/org`, local datasets, and any
  virtual environments that cannot be recreated from project lockfiles.
- Reinstall Mac App Store and licensed/proprietary applications manually.
- Review `APPLICATION_INVENTORY.md` rather than copying every old application.
- Sign into browsers and restore profiles through account sync or an encrypted
  backup, not this repository.
- The core Brewfile installs Hack Nerd Font. Other files in `~/Library/Fonts`
  are intentionally not committed.

## Configuration Audit

Managed now:

- Bash, zsh transition config, Git, GitHub CLI, Neovim, tmux, WezTerm,
  Starship, Atuin, btop, sesh, Television, OpenCode, VS Code settings, and VS
  Code keybindings.

Still intentionally manual or pending review:

- `~/.config/doom`: valuable Doom Emacs config, but it contains stale package
  assumptions and a hard-coded Homebrew Node version. Review before adding.
- `~/.emacs.d`: generated Doom checkout and package data; bootstrap Doom rather
  than copying this roughly 2 GB directory.
- `~/.warp/settings.toml` and `~/.warp/themes`: settings refer to local image
  assets. Use Warp sync or add the selected theme and images deliberately.
- `~/.ssh/config`: useful but contains infrastructure details; sanitize before
  deciding whether a public repository should manage it.
- `~/.claude`, `~/.codex`, `~/.gemini`, and `~/.agents`: mixed hand-written
  agents/skills and private runtime/auth state. Export only reviewed source files.
- JupyterLab preferences and specialized scientific tool configs (`.galpyrc`,
  `.h5forest`, `.h5nry`, `.swiftsim-utils`) are optional and path-sensitive.
- macOS Finder, Dock, keyboard, Rectangle, and screenshot defaults are not yet
  expressed as a reviewed defaults script.
- Homebrew no longer provides the installed `hdf5@1.10` formula. The optional
  manifest uses current `hdf5`; pin 1.10 in a project environment if required.

## Useful Inventories

Run these on the old laptop and save reviewed output with the backup if needed:

```bash
brew leaves
brew list --cask
code --list-extensions > vscode-extensions.txt
mas list > mac-app-store-apps.txt  # after: brew install mas
gh extension list
pyenv versions
uv tool list
```

Restore VS Code extensions with:

```bash
xargs -n 1 code --install-extension < vscode-extensions.txt
```

## Final Old-Laptop Check

```bash
git -C "$HOME/.local/share/chezmoi" status
git -C "$HOME/.local/share/chezmoi" log --oneline origin/main..HEAD
chezmoi diff
```

Commit and push every intended source change. Verify the GitHub repository from
another browser/session before starting the new laptop setup.
