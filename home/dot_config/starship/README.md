# Starship Prompt

This directory manages Starship prompt configuration.

- Source: `home/dot_config/starship/starship.toml`
- Target: `~/.config/starship.toml`

## Design

- Multi-segment powerline-style prompt
- Language/runtime modules for active project context
- Right-side timing information (`cmd_duration`, `time`)
- OS-aware icon via Starship `os` module (macOS/Linux distro aware)
- Includes C/CMake context when relevant project files are present
- Includes OpenStack context when OpenStack environment is active
- Includes memory usage when RAM use crosses configured threshold
- Includes expanded git context (`git_state`, `git_metrics`) for in-progress operations and diff size awareness

## Cross-Platform Behavior

- OS icon is selected automatically by Starship.
- Hostname appears only over SSH (`hostname.ssh_only = true`).
- Optional context modules (Kubernetes, OpenStack, jobs) only render when relevant.
- Kubernetes is constrained to common cluster/project markers (`k8s`, `kubernetes`, `Chart.yaml`, `helmfile.yaml`, `skaffold.yaml`).

## Common Tweaks

- Change truncation depth in `[directory]`
- Add/remove modules in top-level `format`
- Adjust color palette in module `style` values
