# GitHub CLI Configuration

`gh` is the official GitHub command-line client for PRs, issues, releases, and API access.

- Docs: https://cli.github.com/manual/
- Source: `home/dot_config/gh/config.yml`
- Target: `~/.config/gh/config.yml`

## What `config.yml` Sections Mean

- `version`: config schema version used by `gh`.
- `git_protocol`: default clone/push protocol used by `gh` (`https` here).
- `editor`: editor override for PR/issue bodies (blank means shell default).
- `prompt`: whether `gh` should ask interactive questions.
- `pager`: paging behavior for long output.
- `aliases`: custom shorthand commands (for example `co: pr checkout`).
- `browser`: optional browser override for `gh browse`-style actions.

## Security/Portability Rules

- Commit `config.yml` (preferences and aliases).
- Do not commit `~/.config/gh/hosts.yml` (auth/account host state).

If auth breaks on a new machine, re-run `gh auth login` instead of copying `hosts.yml`.
