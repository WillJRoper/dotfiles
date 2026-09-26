#!/bin/bash
set -euo pipefail

if [ "$(uname -s)" != "Darwin" ]; then
    exit 0
fi

if ! command -v npx >/dev/null 2>&1; then
    echo "npx not found; install Node.js before installing Cloudflare skills" >&2
    exit 1
fi

npx --yes skills add cloudflare/skills \
    --global \
    --agent opencode claude-code \
    --skill '*' \
    --yes
