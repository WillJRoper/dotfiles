# Starship Prompt

Starship is a cross-shell prompt engine. It builds prompt segments from context (git, language toolchains, cloud, timers, jobs, etc.).

- Docs: https://starship.rs
- Config reference: https://starship.rs/config/
- Source: `home/dot_config/starship/starship.toml`
- Runtime target: `~/.config/starship.toml`

## How This Prompt Is Built

- `format = """..."""` defines segment order and separators.
- Left side: OS/host, path, git state, language/tooling context.
- Right end: command duration and current time.
- `$character` is the final prompt symbol for success/error states.

## Section Guide For This File

- `[os]` and `[os.symbols]`: platform icon (macOS/Linux distro aware).
- `[hostname]`: host label, limited to SSH sessions (`ssh_only = true`).
- `[directory]`: path display and truncation behavior.
- `[git_branch]`, `[git_status]`, `[git_state]`, `[git_metrics]`: branch, dirty state, in-progress operations, and diff size.
- `[python]`, `[rust]`, `[c]`, `[cmake]`: language/toolchain context when relevant files are detected.
- `[kubernetes]`, `[openstack]`: infrastructure context.
- `[memory_usage]`: RAM/swap summary when usage exceeds threshold.
- `[jobs]`: active background job count.
- `[cmd_duration]` and `[time]`: performance/time awareness.

## Current Intent Of The Configuration

- Keep a rich prompt without showing irrelevant modules constantly.
- Highlight risky repository states (merge/rebase/cherry-pick).
- Show infra context for cluster/cloud workflows.
- Keep visual style cohesive with Catppuccin-like colors and powerline separators.

## Safe Customization Workflow

- Change one module at a time and test with `starship print-config`.
- If a module warns with `Unknown key`, remove unsupported keys rather than forcing them.
- Keep the `format` string and module names aligned; unused module sections do nothing.
