# Core Modules

`lua/core/` defines global Neovim behavior before plugin setup.

## Files

- `options.lua`: editor options (numbers, indent, split behavior, search, diagnostics defaults)
- `keymaps.lua`: global keymaps and leader key setup
- `env.lua`: runtime environment detection (`hostname`, `is_hpc`, `NVIM_HPC` override)
- `snippets.lua`: snippets, small UX autocmds, and shared UI behavior

## Editing Guidance

- Put only cross-cutting behavior here
- Keep plugin-specific options out of `core/` unless absolutely global
- Prefer declarative settings and small helper functions

## Environment Contract

Other modules read environment flags via:

```lua
local env = require('core.env')
if env.is_hpc then
  -- disable internet-dependent features
end
```

This keeps HPC behavior centralized and consistent.
