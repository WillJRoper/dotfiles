# dotfiles

My configuration files for bash, prompt styles, aliases, etc., managed with [Chezmoi](https://www.chezmoi.io/). Works on macOS and Linux.

## Installation

### Prerequisites

1. Install Chezmoi:
   ```bash
   # macOS
   brew install chezmoi
   
   # Linux (various methods)
   # Ubuntu/Debian: snap install chezmoi --classic
   # Arch: pacman -S chezmoi
   # Or install script: sh -c "$(curl -fsLS get.chezmoi.io)"
   ```

2. Install required tools (optional but recommended):
   ```bash
   # macOS
   brew install starship eza bat dust zoxide
   
   # Linux - use your package manager, e.g.:
   # Ubuntu: apt install bat zoxide
   # Arch: pacman -S starship eza bat dust zoxide
   # Or install via cargo: cargo install starship eza bat-fd dust zoxide
   ```

3. Note: ble.sh (for enhanced vim command line editing) will be automatically installed by Chezmoi setup scripts.

### Setup

1. Initialize Chezmoi with this repository:
   ```bash
   chezmoi init https://github.com/WillJRoper/dotfiles.git
   ```

2. Preview what files will be managed:
   ```bash
   chezmoi diff
   ```

3. Apply the dotfiles:
   ```bash
   chezmoi apply
   ```

### What's Included

- **Shell Configuration**: `.aliases`, `.functions`, `.bash_profile`, `.bashrc`
- **Vim Command Line**: Enhanced bash vi mode with ble.sh for vim keybindings on command line
- **Starship**: Custom prompt configuration with git integration
- **WezTerm**: Terminal emulator settings with Catppuccin theme
- **Tmux**: Terminal multiplexer with vim keybindings and plugins
- **Neovim**: Complete editor configuration
- **Git**: Global git configuration
- **Scripts**: Utility scripts including Python project cleanup

### Key Features

- Modern CLI tools integration (eza, bat, dust, zoxide)
- Comprehensive Git aliases
- Python environment management system
- Custom shell functions for development workflow
- Consistent theming across tools (Catppuccin)
- **HPC-Aware**: Automatically disables internet-dependent features (like Copilot) on HPC systems

### Updating

To update your dotfiles:

```bash
chezmoi update
```

To make changes:

1. Edit files in your source directory: `chezmoi cd`
2. Add new files: `chezmoi add ~/.config/newfile`
3. Apply changes: `chezmoi apply`

### Scripts

The included scripts are available system-wide:
- `clean_py_project_install.sh` - Cleans Python build artifacts (aliased as `pip-clean`)

### HPC Environment Support

The configuration automatically detects HPC environments and disables internet-dependent features:

**Detection Methods:**
- Hostname patterns: `cosma`, `login`, `compute`, `node`, `hpc`
- Environment variables: `SLURM_JOB_ID`, `PBS_JOBID`, `SGE_JOB_ID`, `SCHEDULER`

**Disabled on HPC:**
- GitHub Copilot plugins (copilot.lua, copilot-chat.lua)
- Other internet-dependent features as needed

**Manual Override:**
To force HPC mode on any system:
```bash
export SCHEDULER=slurm  # or any value
chezmoi apply
```

For more information about managing dotfiles with Chezmoi, see the [Chezmoi documentation](https://www.chezmoi.io/docs/).