# 5. Restore Applications And Data

## Applications

Core Homebrew applications were installed in phase 3. Review
[`../docs/APPLICATION_INVENTORY.md`](../docs/APPLICATION_INVENTORY.md) before
installing anything else.

The first `chezmoi apply` also restores the reviewed Dock layout, including its
small spacer groups. To reapply only that layout after reviewing the script:

```bash
bash "$(chezmoi source-path)/run_once_configure-dock.sh"
```

Install only applications still needed:

- Mac App Store applications
- Licensed Adobe, Microsoft, Maxon, and specialist tools
- Browsers and communication applications
- Cloud storage clients
- Hardware utilities
- Research-specific software

Core setup includes Arc, Raycast, Slack, Tailscale, Obsidian, Microsoft Teams,
WhatsApp, Zoom, VLC, Thunderbird, and Steam. Tailscale requires approval in
System Settings for its system extension. Sign in to each service when first
opened; the setup agent must pause for these human interactions.

Avoid automatically copying legacy cleaners, old VPN clients, duplicate app
versions, or generated application state.

## User Data

Restore from authoritative remotes or encrypted backups:

- Research repositories and `~/SecondBrain`
- The NASA ADS MCP repository at `~/mcp/nasa-ads-mcp`, if still used
- `~/org`, teaching material, documents, and datasets
- Browser profiles through browser sync or an encrypted profile backup
- Dropbox, OneDrive, and Box content through their clients

Do not copy Python virtual environments when project lockfiles can recreate
them. Install historical pyenv versions only when an active project requires
them.

## Deliberately Excluded Configuration

The repository does not migrate:

- Doom Emacs and generated `~/.emacs.d` state
- Warp settings and themes
- Codex configuration and authentication
- Gemini configuration and authentication
- Vorssaint clipboard history, shelf files, or scratchpad content
- Application caches, histories, sessions, OAuth databases, or browser cookies

## Component Checks

- Confirm VS Code extensions installed from `~/.config/vscode/extensions.txt`.
- Open Vorssaint once and complete its onboarding and permission prompts. Quit
  it completely, then reapply its managed preferences because first launch can
  replace defaults written during the initial Chezmoi apply:

  ```bash
  bash "$(chezmoi source-path)/run_once_configure-vorssaint.sh"
  open -a Vorssaint
  ```

  The sanitized old-Mac activation and capability reference is
  `setup/vorssaint-state.toml`. Verify shortcuts, keep-awake, monitoring, shelf,
  and URL cleaner preferences.
- Open Neovim and allow plugins/tooling to finish initial installation.
- Open Docker Desktop once to complete privileged helper setup.

Continue to [`06_verify_setup.md`](06_verify_setup.md).
