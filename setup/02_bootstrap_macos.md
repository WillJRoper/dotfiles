# 2. Bootstrap macOS

These instructions assume a clean Mac that was not restored from an iCloud
backup.

## Apple Services

Sign in with the same Apple Account used on the current Mac. In **System
Settings > Apple Account > iCloud**, enable:

- Passwords & Keychain
- iCloud Drive

Wait for Apple Passwords and iCloud Drive to finish their initial sync.

## System Updates

Install current macOS updates. Install Xcode from the Mac App Store if needed,
then install its command-line tools:

```bash
xcode-select --install
```

Confirm the tools are available:

```bash
xcode-select -p
```

## Homebrew

Install Homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the installer instructions to load `brew shellenv` into the current
terminal. Confirm installation:

```bash
brew --version
brew doctor
```

Review `brew doctor` warnings rather than applying suggested destructive changes
blindly.

## Chezmoi

Install Chezmoi, but do not initialize with `--apply`:

```bash
brew install chezmoi
chezmoi --version
```

Continue to [`03_install_dotfiles.md`](03_install_dotfiles.md).
