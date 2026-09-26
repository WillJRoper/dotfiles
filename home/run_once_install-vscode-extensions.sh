#!/bin/bash
set -euo pipefail

if [ "$(uname -s)" != "Darwin" ]; then
    exit 0
fi

EXTENSION_FILE="$HOME/.config/vscode/extensions.txt"
CODE_BIN="$(command -v code || true)"

if [ -z "$CODE_BIN" ] && [ -x "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" ]; then
    CODE_BIN="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
fi
if [ -z "$CODE_BIN" ]; then
    echo "VS Code CLI not found; install Visual Studio Code before installing extensions" >&2
    exit 1
fi

while IFS= read -r extension || [ -n "$extension" ]; do
    case "$extension" in
        ""|\#*) continue ;;
        *) "$CODE_BIN" --install-extension "$extension" ;;
    esac
done < "$EXTENSION_FILE"
