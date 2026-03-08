# Lua Module Map

This directory contains all Lua modules loaded by `init.lua`.

- `core/`: global editor behavior (options, mappings, environment, snippets)
- `plugins/`: lazy.nvim plugin specs and plugin-specific config
- `utils/`: shared helper modules used by core and plugins

## Design Rules

- Keep startup logic in `init.lua` minimal
- Keep global behavior in `core/`
- Keep plugin concerns in `plugins/` (one file per plugin/feature)
- Keep reusable helpers in `utils/`

## Naming and Style

- Plugin files use hyphenated names (for example `treesitter-text-objects.lua`)
- Local variables and function names are snake_case
- Formatting is enforced with Stylua (`.stylua.toml`)
