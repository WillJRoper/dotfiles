#!/bin/bash

# Make scripts directory in PATH
SCRIPT_DIR="$HOME/scripts"

# Create scripts directory if it doesn't exist
mkdir -p "$SCRIPT_DIR"

# Ensure managed scripts are executable when present
if [ -f "$SCRIPT_DIR/clean_py_project_install.sh" ]; then
    chmod +x "$SCRIPT_DIR/clean_py_project_install.sh"
fi
