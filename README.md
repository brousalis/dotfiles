# dotfiles

Pete Brousalis's development setup for macOS, Linux, WSL and Windows, managed
with [chezmoi](https://www.chezmoi.io). Neovim (LazyVim), tmux, WezTerm, zsh or
PowerShell, git, mise, and Claude Code, configured the same way everywhere.

The history goes back to 2011. The setup from before this rewrite is tagged
[`legacy`](https://github.com/brousalis/dotfiles/tree/legacy).

## Install

macOS, Linux or WSL:

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/brousalis/dotfiles/v2/install.sh)"

Windows (PowerShell):

    irm https://raw.githubusercontent.com/brousalis/dotfiles/v2/install.ps1 | iex

Always read a script before you curl it: [install.sh](install.sh), [install.ps1](install.ps1).

The bootstrap installs chezmoi, clones this repo to `~/.dotfiles`, asks for your
name, email and whether this is a work machine, then applies everything:
packages (Homebrew or winget), runtimes (mise), shell, editor, terminal, git,
and Claude Code. Re-running it is safe.

## Day to day

| Task | Command |
| --- | --- |
| Pull and apply the latest | `chezmoi update` |
| Edit a managed file | `chezmoi edit ~/.zshrc` (or edit in `~/.dotfiles`, then `chezmoi apply`) |
| See what would change | `chezmoi diff` |
| Bring back a file edited in place | `chezmoi re-add ~/.tmux.conf` |
| Add a package | edit `home/.chezmoidata/packages.yaml`, then `chezmoi apply` |

Machine-only settings stay out of the repo: `~/.localrc`, `~/.localenv`,
`~/.gitconfig.local`, `~/.tmux.local.conf`, `~/.localrc.ps1`, and
`~/.config/wezterm/local.lua`.

## What's here

| Area | Tool | Source |
| --- | --- | --- |
| Packages | Homebrew (macOS, Linux), winget (Windows) | `home/.chezmoidata/packages.yaml` |
| Shell | zsh + antidote + starship; PowerShell 7 + starship | `home/dot_zshrc`, `home/dot_config/powershell/` |
| Aliases | Kept from the original dotfiles, ported to PowerShell | `home/dot_aliases`, `home/dot_config/powershell/aliases.ps1` |
| Multiplexer | tmux + TPM (macOS, Linux, WSL) | `home/dot_tmux.conf` |
| Terminal | WezTerm, with the tmux keys on native Windows | `home/dot_config/wezterm/wezterm.lua` |
| Editor | Neovim with LazyVim, comma leader, old vimrc mappings | `home/dot_config/nvim/` |
| Runtimes | mise (node, python, go, pnpm, uv) | `home/dot_config/mise/config.toml` |
| Git | delta, rebase on pull, per-OS credentials, gh for GitHub | `home/dot_gitconfig.tmpl` |
| AI agents | One rules file for Claude Code, Codex and Gemini | `home/.chezmoitemplates/rules.md` |
| Claude Code | Settings, status line, skills, MCP servers | `home/dot_claude/`, `home/.chezmoidata/claude.yaml` |

## Keys

tmux (prefix `C-a`), unchanged from the original config. On native Windows,
WezTerm uses the same keys.

| Key | Action |
| --- | --- |
| `C-a h/j/k/l` | Move between panes |
| `C-a C-a` | Cycle panes |
| `C-a s` / `C-a v` | Split side by side / stacked |
| `F1` / `F2`, `F11` / `F12` | Previous / next window |
| `Alt+arrows` | Resize pane |
| `Alt+0` | Choose session |
| `C-a Escape` | Copy mode |
| `C-a R` | Reload config |
| `C-a C` | Open Claude Code in a pane on the right (added) |

`ide [dir]` starts or re-attaches a tmux session for a project with Neovim on
the left and Claude Code on the right. In Claude Code, run `/ide` to connect to
that Neovim (via claudecode.nvim) for selection context and diffs in the editor.

Neovim (leader `,`): the old vimrc mappings carry over (`jj`/`jk` to escape,
`;` for `:`, `,<space>` clears search, `tj`/`tk` and `F1`/`F2` for tabs,
`,h/j/k/l` between windows, Tab to indent). Two changes: `K` is LSP hover and
the old split-line moved to `,K`; Enter opens a line below only in normal file
buffers.

### VS Code keys (opt-in)

Off by default. Turn on per machine with `NVIM_VSCODE_KEYS=1` (in
`~/.localenv`, or `$env:NVIM_VSCODE_KEYS = '1'` in `~/.localrc.ps1`), or
everywhere with `vim.g.vscode_keys = true` in `lua/config/options.lua`.

| Key | Action |
| --- | --- |
| `Ctrl+P` / `Ctrl+B` / `Ctrl+G` | Go to file / toggle explorer / go to line |
| `Ctrl+/` | Toggle comment (terminal toggle stays on `,ft`) |
| `Alt+Shift+j` / `k` | Copy line down / up (`Alt+j` / `k` move it) |
| `Alt+Shift+f` | Format |
| `Alt+.` | Quick fix |
| `F8` / `Shift+F8` | Next / previous problem |
| `Alt+1` to `Alt+9`, `Alt+w` | Go to buffer N, close buffer |
| `Ctrl+Shift+P/F/O/E/G/M` | Commands, search, symbols, explorer, git, problems (needs a terminal that sends extended keys; `,sC` `,/` `,ss` `,e` `,gg` `,xx` always work) |

It replaces Vim's `Ctrl+P`, `Ctrl+B` and `Ctrl+G`. F2 (rename) isn't mapped
because tmux uses `F1` / `F2`; use `,cr`.

## Layout

    .chezmoiroot              chezmoi reads home/ as the source
    install.sh, install.ps1   bootstrap
    home/
      .chezmoi.toml.tmpl      init questions and per-machine config
      .chezmoidata/           package lists, MCP servers
      .chezmoiscripts/        installs and setup, per OS
      .chezmoitemplates/      shared agent rules, Claude Code settings
      .chezmoiexternal.toml.tmpl  TPM and antidote
      dot_*                   files that land in ~
