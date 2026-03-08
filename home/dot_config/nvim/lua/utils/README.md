# Utility Modules

`lua/utils/` contains shared helpers used across core and plugin config.

## Files

- `icons.lua`: icon tables used by UI components and plugin displays
- `startpage-headers.lua`: dashboard/start page header content
- `myfunctions/comments.lua`: custom comment alignment helper(s)

## When to Add Code Here

Add logic to `utils/` when it is:

- reused by multiple modules, or
- domain-specific helper logic that does not belong to one plugin file

If logic is only used by one plugin, keep it with that plugin spec.
