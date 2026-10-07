#!/bin/sh
# Bootstrap these dotfiles on macOS, Linux or WSL:
#
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/brousalis/dotfiles/v2/install.sh)"
#
# Or from a clone: ./install.sh
set -eu

REPO="${DOTFILES_REPO:-brousalis/dotfiles}"
BRANCH="${DOTFILES_BRANCH:-v2}"
DEST="${DOTFILES_DIR:-$HOME/.dotfiles}"

if ! command -v chezmoi >/dev/null 2>&1; then
  BIN="$HOME/.local/bin"
  mkdir -p "$BIN"
  sh -c "$(curl -fsSL https://get.chezmoi.io)" -- -b "$BIN"
  PATH="$BIN:$PATH"
fi

script_dir="$(cd "$(dirname "$0")" 2>/dev/null && pwd || true)"
if [ -n "$script_dir" ] && [ -f "$script_dir/.chezmoiroot" ]; then
  exec chezmoi init --apply --source "$script_dir"
fi

exec chezmoi init --apply --branch "$BRANCH" --source "$DEST" "$REPO"
