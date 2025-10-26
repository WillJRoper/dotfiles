#!/bin/bash

# Install ble.sh (Bash Line Editor) for enhanced vim mode
# This provides sophisticated command line editing with vim keybindings

BLE_DIR="$HOME/.local/share/blesh"

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
    cd "$BLE_DIR"
    make install PREFIX="$HOME/.local"
else
    # Fallback: download release
    echo "Git not found, downloading release..."
    curl -L https://github.com/akinomyoga/ble.sh/releases/latest/download/ble-nightly.tar.xz -o /tmp/ble.tar.xz
    mkdir -p "$BLE_DIR"
    tar -xf /tmp/ble.tar.xz -C "$BLE_DIR" --strip-components=1
    rm /tmp/ble.tar.xz
fi

echo "ble.sh installation completed!"
echo "Enhanced vim mode will be available in new bash sessions."