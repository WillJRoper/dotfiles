#!/bin/bash
set -euo pipefail

TPM_DIR="$HOME/.config/tmux/plugins/tpm"

if [[ ! -d "$TPM_DIR/.git" ]]; then
    git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi
