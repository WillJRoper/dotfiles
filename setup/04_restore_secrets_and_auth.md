# 4. Restore Secrets And Authentication

Complete this phase only after Apple Passwords and iCloud Drive have synced.

## Restore Environment Secrets

Check whether the encrypted backup is available:

```bash
dotfiles-secrets-icloud status
```

Expected state on a new Mac:

```text
Local secrets: missing
iCloud backup: present
```

Restore the file, using the `Dotfiles secrets` password from Apple Passwords:

```bash
dotfiles-secrets-icloud restore
```

Restore refuses to overwrite an existing file. If one exists, inspect it rather
than deleting it blindly.

Verify permissions and shell syntax without displaying values:

```bash
stat -f '%Sp %N' "$HOME/.config/dotfiles" "$HOME/.config/dotfiles/secrets.sh"
bash -n "$HOME/.config/dotfiles/secrets.sh"
```

Open a new terminal so `.bash_profile` loads the restored variables.

## Restore SSH And GPG

SSH config was restored by `chezmoi apply`. Generate fresh Ed25519 keys using
the filenames referenced by SSH config and Git config:

```bash
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
ssh-keygen -t ed25519 -a 100 -f "$HOME/.ssh/id_rsa" -C "HPC access"
ssh-keygen -t ed25519 -a 100 -f "$HOME/.ssh/artemis" -C "Artemis access"
ssh-keygen -t ed25519 -a 100 -f "$HOME/.ssh/ghub_key" -C "GitHub"
ssh-add --apple-use-keychain \
    "$HOME/.ssh/id_rsa" "$HOME/.ssh/artemis" "$HOME/.ssh/ghub_key"
```

Use passphrases. Register `id_rsa.pub` with COSMA, ARC, and BMRC; register
`artemis.pub` with Artemis. Those connections will fail until administrators or
self-service portals install the replacement public keys. Do not copy the old
private keys unless a service cannot rotate them.

Restore GPG keys separately if they are still required. Never commit private
keys.

## Authenticate Tools

```bash
gh auth login
gh auth setup-git
KEY_TITLE="$(scutil --get ComputerName)"
gh ssh-key add "$HOME/.ssh/ghub_key.pub" --type authentication --title "$KEY_TITLE"
gh ssh-key add "$HOME/.ssh/ghub_key.pub" --type signing --title "$KEY_TITLE signing"
chezmoi apply -- "$HOME/.gitconfig"
git lfs install
atuin login
aws login --profile agent-toolkit
```

Install GitHub Copilot CLI extension after GitHub authentication:

```bash
gh extension install github/gh-copilot
```

Then:

- Sign in to Docker Desktop.
- Start OpenCode and complete OAuth for enabled Cloudflare MCP servers.
- Authenticate Claude Code when first launched.
- Authenticate Obsidian and NASA ADS integrations using variables restored from
  `secrets.sh`. NASA ADS also requires its checkout at `~/mcp/nasa-ads-mcp`.
- Restart OpenCode after config changes because it loads configuration only at
  startup.

Codex and Gemini configuration/authentication are intentionally not migrated.

Continue to [`05_restore_apps_and_data.md`](05_restore_apps_and_data.md).
