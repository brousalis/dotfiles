# Personal rules for coding agents

These are my standing preferences across every project. A repository's own
CLAUDE.md or AGENTS.md wins where the two disagree. This file is generated from
`~/.dotfiles/home/.chezmoitemplates/rules.md`; edit it there, not here.

## How to work with me

- I'm a principal engineer. Skip the basics, lead with the answer, keep it short.
- When a request is ambiguous, pick the sensible default, say which one, and keep going.
- Back up claims with what you checked: a file and line, a command and its output, a link.
- Say plainly when something failed, was skipped, or is a guess.

## Code

- Match the style, naming and patterns of the surrounding code before your own preferences.
- Prefer small, reviewable changes. Don't refactor unrelated code in the same change.
- Don't add a dependency when a few lines will do; when you do add one, say why.
- Write comments only where the code can't explain itself.
- Handle errors where they can be handled; don't swallow them.

## Verifying

- Run the project's tests, linter and type checker before saying a change is done.
- When fixing a bug, reproduce it first, and add a test that fails without the fix when practical.
- If something can't be verified locally, say what is unverified.

## Git

- Never rewrite published history, force-push a shared branch, or skip hooks unless I ask.
- Commit messages: a short imperative summary line, then the why in the body.
- Never commit secrets, `.env` files, or credentials. Flag any you find.

## Environment

- I work across macOS, Linux (including WSL) and Windows. Scripts meant to be
  portable should run on all three, or say which they support.
- Shell: zsh on Unix, PowerShell 7 on Windows. Editor: Neovim. Multiplexer: tmux.
- Runtimes come from mise; check `mise.toml` or `.tool-versions` before assuming versions.
