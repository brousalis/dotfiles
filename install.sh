#!/bin/sh
# Bootstrap these dotfiles on macOS, Linux or WSL:
#
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/brousalis/dotfiles/master/install.sh)"
#
# Or from a clone: ./install.sh
set -eu

REPO="${DOTFILES_REPO:-brousalis/dotfiles}"
BRANCH="${DOTFILES_BRANCH:-master}"
DEST="${DOTFILES_DIR:-$HOME/.dotfiles}"

if ! command -v chezmoi >/dev/null 2>&1; then
  BIN="$HOME/.local/bin"
  mkdir -p "$BIN"
  sh -c "$(curl -fsSL https://get.chezmoi.io)" -- -b "$BIN"
  PATH="$BIN:$PATH"
fi

script_dir="$(cd "$(dirname "$0")" 2>/dev/null && pwd)" || script_dir=""
if [ -n "$script_dir" ] && [ -f "$script_dir/.chezmoiroot" ]; then
  exec chezmoi init --apply --source "$script_dir"
fi

# An older clone of this repo (before chezmoi) may already be at $DEST, for
# example the original ~/.dotfiles on a Mac. Move it to the chezmoi branch
# first, or chezmoi would apply the old layout.
if [ -d "$DEST/.git" ] && [ ! -f "$DEST/.chezmoiroot" ]; then
  echo "Switching existing $DEST to $BRANCH"
  git -C "$DEST" fetch origin "$BRANCH"
  git -C "$DEST" switch "$BRANCH" 2>/dev/null || git -C "$DEST" switch -c "$BRANCH" --track "origin/$BRANCH"
  git -C "$DEST" merge --ff-only "origin/$BRANCH"
fi
if [ -f "$DEST/.chezmoiroot" ]; then
  exec chezmoi init --apply --source "$DEST"
fi

exec chezmoi init --apply --branch "$BRANCH" --source "$DEST" "$REPO"
