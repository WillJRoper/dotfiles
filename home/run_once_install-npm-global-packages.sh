#!/bin/bash
set -euo pipefail

PACKAGE_FILE="$HOME/.config/npm/global-packages.txt"

if ! command -v npm >/dev/null 2>&1; then
    echo "npm not found; install Node.js before installing global npm packages" >&2
    exit 1
fi

packages=()
while IFS= read -r package || [ -n "$package" ]; do
    case "$package" in
        ""|\#*) continue ;;
        *) packages+=("$package") ;;
    esac
done < "$PACKAGE_FILE"

npm install --global "${packages[@]}"

codegraph install --target=claude --location=global --yes
