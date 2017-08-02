#!/usr/bin/env bash

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd)/home

set -e
echo ''

info () {
  printf "  [ \033[00;34m..\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

remove_dotfiles () {
  info 'removing dotfiles'
  for src in $(find "$DOTFILES_ROOT"/* -maxdepth 2 -name '*' ! -name 'gitconfig')
  do
    dst="$HOME/.$(basename "${src}")"
    if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then
      rm $dst
      success "removed $dst"
    fi
  done
}

remove_vim () {
  info 'removing vim plugins'
  rm -rf $HOME/.vim
}

remove_dotfiles
remove_vim

echo ''
echo '  All removed'
