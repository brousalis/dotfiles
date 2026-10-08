#!/usr/bin/env bash
# Claude Code status line: directory, git branch, model.
# Reads the session JSON on stdin. Works in bash on macOS, Linux and Git Bash.

input=$(cat)
field() { printf '%s' "$input" | jq -r "$1 // empty" 2>/dev/null; }

# Hand the 5h rate-limit usage to the tmux status bar (see tmux-claude-usage).
pct=$(field '.rate_limits.five_hour.used_percentage')
if [ -n "$pct" ]; then
  cache="${XDG_CACHE_HOME:-$HOME/.cache}"; mkdir -p "$cache"
  printf '%s %s\n' "${pct%.*}" "$(field '.rate_limits.five_hour.resets_at')" > "$cache/claude-rate-limit"
fi

dir=$(field '.workspace.current_dir')
model=$(field '.model.display_name')
[ -n "$dir" ] || dir=$PWD

branch=$(git -C "$dir" branch --show-current 2>/dev/null)
dirty=""
if [ -n "$branch" ] && [ -n "$(git -C "$dir" status --porcelain 2>/dev/null | head -1)" ]; then
  dirty="*"
fi

blue=$'\e[34m'; yellow=$'\e[33m'; dim=$'\e[2m'; reset=$'\e[0m'
printf '%s%s%s' "$blue" "${dir##*/}" "$reset"
[ -n "$branch" ] && printf ' %s%s%s%s' "$yellow" "$branch" "$dirty" "$reset"
[ -n "$model" ] && printf ' %s%s%s' "$dim" "$model" "$reset"
