# OpenCode Configuration

This directory contains OpenCode settings and custom agent prompts.

- Source: `home/dot_config/opencode/opencode.json.tmpl`
- Target: `~/.config/opencode/opencode.json`
- Agents: `home/dot_config/opencode/agents/*.md`

## Portability

`opencode.json` is managed as a Chezmoi template so machine-specific paths are rendered from your home directory by default.

Optional environment overrides supported by the template:

- `SECOND_BRAIN_DIR`
- `ARXIV_STORAGE_DIR`
- `NASA_ADS_MCP_DIR`
- `JOBS_DIR`
- `DOCUMENTS_JOBS_DIR`

If these are unset, defaults are derived from `{{ .chezmoi.homeDir }}`.

## Secrets

API tokens remain environment-driven and are not stored in git:

- `OBSIDIAN_API_KEY`, `OBSIDIAN_HOST`, `OBSIDIAN_PORT`
- `ADS_API_TOKEN`
