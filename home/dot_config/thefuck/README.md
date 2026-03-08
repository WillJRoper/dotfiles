# The Fuck Configuration

`thefuck` suggests corrections for mistyped shell commands (for example, typoed command names or missing `sudo`).

- Project: https://github.com/nvbn/thefuck
- Settings docs: https://github.com/nvbn/thefuck#settings
- Source: `home/dot_config/thefuck/settings.py`
- Target: `~/.config/thefuck/settings.py`

## File Structure

`settings.py` is plain Python with optional variables. In this repo, it intentionally stays near-default and serves as a documented template for future tuning.

Common settings you may want to enable:

- `rules` / `exclude_rules`: opt into or out of specific fixers.
- `require_confirmation`: safety confirmation before running proposed fix.
- `wait_command`: timeout for expensive command analysis.
- `history_limit`: cap how much shell history is scanned.
- `instant_mode`: apply fixes more aggressively with fewer prompts.

## Shell Integration

The alias hook is initialized in Bash via `eval "$(thefuck --alias)"` in `~/.bashrc`.
