# 1. Prepare The Current Mac

Complete this phase before setting up the new Mac. Keep the current Mac intact
until the final verification phase passes.

## Update Exposed Credentials

`SYNTH_BOX_SECRET` and `SYNTH_DEV_TOKEN` previously appeared in Git history.
Rotate them at their providers, update
`~/.config/dotfiles/secrets.sh`, and invalidate the old values.

Confirm the private file remains local and protected:

```bash
stat -f '%Sp %N' "$HOME/.config/dotfiles" "$HOME/.config/dotfiles/secrets.sh"
```

Expected modes are `drwx------` for the directory and `-rw-------` for the file.

## Back Up Secrets

Enable **Passwords & Keychain** and **iCloud Drive** in System Settings. In
Apple Passwords, create an entry with:

- Name: `Dotfiles secrets`
- Website: `dotfiles.local`
- Username: `willroper`
- Password: a generated strong password

Encrypt the local secrets file. Paste the generated password when prompted:

```bash
dotfiles-secrets-icloud backup
dotfiles-secrets-icloud status
```

Expected status:

```text
Local secrets: present
iCloud backup: present
```

Only authenticated `age` ciphertext is placed in iCloud Drive. Never add
`~/.config/dotfiles/secrets.sh` to Chezmoi or Git.

## Push Dotfiles

The new Mac clones the remote repository, not local commits. Locate the
repository and verify it is clean and pushed:

```bash
REPO_ROOT="$(dirname "$(chezmoi source-path)")"
git -C "$REPO_ROOT" status
git -C "$REPO_ROOT" log --oneline origin/main..HEAD
git -C "$REPO_ROOT" push
```

The second command should produce no commits after pushing.

## Secure Non-Dotfile Material

- Store the `AGE-SECRET-KEY-...` line from
  `~/.config/chezmoi/key.txt` in Apple Passwords:

  - Name: `Chezmoi age identity`
  - Username: `dotfiles`
  - Website: `chezmoi`
  - Password: the complete `AGE-SECRET-KEY-...` line
  - Note: the `age1...` public key from the file's `# public key:` line

  Never store the age identity file in Git.
- Confirm projects, `~/SecondBrain`, `~/org`, documents, and datasets have an
  authoritative remote or encrypted backup.
- Confirm each SSH service offers a way to register replacement public keys.
  Generate fresh private keys on the new Mac; do not transfer old ones unless a
  service cannot rotate them. SSH config is managed as an encrypted Chezmoi
  file.
- Export GPG private keys securely if still required.
- Confirm browser, Atuin, Dropbox, OneDrive, and Box sync has completed.
- Keep AWS, Docker, GitHub, and other authentication databases out of Git.

Review [`../docs/MIGRATION_CHECKLIST.md`](../docs/MIGRATION_CHECKLIST.md) before
continuing.

## Completion Check

- Dotfiles repository is clean and pushed.
- Rotated credentials are in the local secrets file.
- Encrypted secrets backup is present in iCloud Drive.
- Chezmoi age identity is present in Apple Passwords.
- Important projects and personal data have separate backups.

Continue to [`02_bootstrap_macos.md`](02_bootstrap_macos.md).
