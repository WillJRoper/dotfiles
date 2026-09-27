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

Copy SSH private keys through the encrypted channel chosen in phase 1. SSH
config is restored by `chezmoi apply` from its encrypted source. Set restrictive
permissions:

```bash
chmod 700 "$HOME/.ssh"
chmod 600 \
    "$HOME/.ssh/config" "$HOME/.ssh/"*_key "$HOME/.ssh/id_"* \
    2>/dev/null || true
chmod 644 "$HOME/.ssh/"*.pub 2>/dev/null || true
```

Restore GPG keys separately if they are still required. Never commit private
keys.

## Authenticate Tools

```bash
gh auth login
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
