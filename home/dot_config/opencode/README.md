# OpenCode Configuration

OpenCode is your local AI coding CLI environment. This directory defines its MCP servers, tool permissions, and agent prompt library.

- Docs: https://opencode.ai
- Source template: `home/dot_config/opencode/opencode.json.tmpl`
- Installed target: `~/.config/opencode/opencode.json`
- Agent prompts: `home/dot_config/opencode/agents/*.md`

## `opencode.json.tmpl` Section Guide

- template variables (top of file): build portable paths from `{{ .chezmoi.homeDir }}` and optional env overrides.
- `mcp`: declares local MCP servers (`obsidian`, `arxiv`, `nasa_ads`) and how each is launched.
- `tools`: per-tool glob permissions/denials.
- `permission.task`: allows task agents to run.
- `permission.external_directory`: explicit external path allowlist for tool access.

## Portability Design

This config is templated so it works across machines without hardcoding `/Users/willroper/...`.

Supported overrides:

- `SECOND_BRAIN_DIR`
- `ARXIV_STORAGE_DIR`
- `NASA_ADS_MCP_DIR`
- `JOBS_DIR`
- `DOCUMENTS_JOBS_DIR`

If unset, defaults are derived from the current user's home directory.

## Secrets and Credentials

Secrets are intentionally read from environment variables instead of committed JSON values:

- `OBSIDIAN_API_KEY`, `OBSIDIAN_HOST`, `OBSIDIAN_PORT`
- `ADS_API_TOKEN`

Do not commit runtime dependency directories (`node_modules`) or lock/runtime artifacts for this config tree.
