#!/bin/bash
set -euo pipefail

if ! command -v npx >/dev/null 2>&1; then
    echo "npx not found; install Node.js before installing Caveman" >&2
    exit 1
fi

# Caveman's installer uses each agent's native installation mechanism and
# preserves existing Claude Code and OpenCode configuration.
npx -y github:JuliusBrussee/caveman -- \
    --only claude \
    --only opencode \
    --non-interactive
