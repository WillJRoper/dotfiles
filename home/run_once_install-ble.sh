#!/bin/bash
set -euo pipefail

# Install ble.sh (Bash Line Editor) for enhanced vim mode
# This provides sophisticated command line editing with vim keybindings

BLE_DIR="$HOME/.local/share/blesh"
TMP_ARCHIVE="$(mktemp -t ble.XXXXXX.tar.xz)"
trap 'rm -f "$TMP_ARCHIVE"' EXIT

# Check if ble.sh is already installed
if [ -f "$BLE_DIR/ble.sh" ]; then
    echo "ble.sh already installed at $BLE_DIR"
    exit 0
fi

echo "Installing ble.sh (Bash Line Editor)..."

# Create directory
mkdir -p "$HOME/.local/share"

# Download and install ble.sh
if command -v git >/dev/null 2>&1; then
    # Install via git (recommended)
    git clone --recursive https://github.com/akinomyoga/ble.sh.git "$BLE_DIR"
    make -C "$BLE_DIR" install PREFIX="$HOME/.local"
else
    # Fallback: download release
    echo "Git not found, downloading release..."
    curl -fL https://github.com/akinomyoga/ble.sh/releases/latest/download/ble-nightly.tar.xz -o "$TMP_ARCHIVE"
    mkdir -p "$BLE_DIR"
    tar -xf "$TMP_ARCHIVE" -C "$BLE_DIR" --strip-components=1
fi

test -f "$BLE_DIR/ble.sh"
echo "ble.sh installation completed!"
echo "Enhanced vim mode will be available in new bash sessions."
