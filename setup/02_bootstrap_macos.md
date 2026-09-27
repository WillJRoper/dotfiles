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

Persist Homebrew's environment for the initial zsh session and the first Bash
login, then load it into the current terminal:

```bash
BREW_BIN="/opt/homebrew/bin/brew"
[ -x "$BREW_BIN" ] || BREW_BIN="/usr/local/bin/brew"
BREW_SHELLENV="eval \"\$($BREW_BIN shellenv)\""

for PROFILE in "$HOME/.zprofile" "$HOME/.bash_profile"; do
    touch "$PROFILE"
    grep -qxF "$BREW_SHELLENV" "$PROFILE" || \
        printf '%s\n' "$BREW_SHELLENV" >> "$PROFILE"
done

eval "$("$BREW_BIN" shellenv)"
```

Chezmoi later replaces the temporary `.bash_profile` with the managed version,
which contains equivalent Apple Silicon and Intel Homebrew initialization.
Confirm installation:

```bash
brew --version
brew doctor
```

Review `brew doctor` warnings rather than applying suggested destructive changes
blindly.

## Bash

Install Homebrew Bash and make it the login shell before continuing:

```bash
brew install bash
BREW_BASH="$(brew --prefix)/bin/bash"
grep -qxF "$BREW_BASH" /etc/shells || echo "$BREW_BASH" | sudo tee -a /etc/shells
chsh -s "$BREW_BASH"
```

Close and reopen the terminal, then confirm:

```bash
echo "$SHELL"
bash --version
```

`echo "$SHELL"` should print the Homebrew Bash path.

## Chezmoi

Install Chezmoi, but do not initialize with `--apply`:

```bash
brew install chezmoi
chezmoi --version
```

Continue to [`03_install_dotfiles.md`](03_install_dotfiles.md).
