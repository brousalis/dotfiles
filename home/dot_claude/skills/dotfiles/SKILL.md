---
name: dotfiles
description: Change Pete's dotfiles (chezmoi repo at ~/.dotfiles) safely across macOS, Linux, WSL and Windows. Use when asked to add or change shell, editor, terminal, git, package or Claude Code config.
---

# Changing the dotfiles

The dotfiles are a chezmoi source repo, usually at `~/.dotfiles`
(`chezmoi source-path` prints the `home/` directory inside it).

## Rules

- Edit files in the source repo, never the applied copies in `~`. Then run
  `chezmoi diff` to review and `chezmoi apply` to apply.
- If a file in `~` was changed directly, pull it back with `chezmoi re-add <path>`.
- Don't rewrite git history; this repo's commits go back to 2011 and are kept on purpose.
- Keep the tmux keybindings block at the top of `home/dot_tmux.conf` unchanged
  unless asked. Add new bindings under "Additions".
- When adding an alias to `home/dot_aliases`, add the PowerShell version to
  `home/dot_config/powershell/aliases.ps1` too.

## Where things live

| What | Source path |
| --- | --- |
| Packages (brew, casks, winget, PowerShell modules) | `home/.chezmoidata/packages.yaml` |
| Install and setup scripts | `home/.chezmoiscripts/` |
| Files per OS | `home/.chezmoiignore` (template) |
| zsh | `home/dot_zshenv`, `dot_zprofile`, `dot_zshrc`, `dot_zsh_plugins.txt` |
| PowerShell | `home/dot_config/powershell/` |
| git | `home/dot_gitconfig.tmpl`, `home/dot_config/git/ignore` |
| Neovim (LazyVim) | `home/dot_config/nvim/` |
| WezTerm | `home/dot_config/wezterm/wezterm.lua` |
| Runtimes | `home/dot_config/mise/config.toml` |
| Agent rules (Claude, Codex, Gemini) | `home/.chezmoitemplates/rules.md` |
| Claude Code settings | `home/.chezmoitemplates/claude-settings.json` (merged into `~/.claude/settings.json`) |
| Claude Code skills | `home/dot_claude/skills/` |
| MCP servers | `home/.chezmoidata/claude.yaml` |

## chezmoi naming

`dot_x` becomes `.x`, `executable_` sets +x, `.tmpl` makes a template,
`modify_` edits an existing file, and `run_onchange_` scripts re-run when their
rendered content changes (include a hash of the file they depend on).

## Checking a change

- `chezmoi execute-template < file.tmpl` renders a template.
- `chezmoi apply --dry-run --verbose` shows what would change.
- For anything OS-specific, check every branch of the `.chezmoi.os` conditions
  and say which OSes you could not test.
