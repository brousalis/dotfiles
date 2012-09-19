#!/bin/bash

FOLDER="$HOME"/dotfiles

# install vim
if [ "$1" == "vim" ]
then
  source vim.sh    
  echo "Setup vim install"
fi

# dotfiles
cd      "$FOLDER"
ln -sf  "$FOLDER"/vimrc         "$HOME"/.vimrc
ln -sf  "$FOLDER"/bashrc        "$HOME"/.bashrc
ln -sf  "$FOLDER"/bash_profile  "$HOME"/.bash_profile
ln -sf  "$FOLDER"/vim           "$HOME"/.vim
ln -sf  "$FOLDER"/screenrc      "$HOME"/.screenrc
ln -sf  "$FOLDER"/tmuxconf      "$HOME"/.tmux.conf
ln -sf  "$FOLDER"/gemrc         "$HOME"/.gemrc
ln -sf  "$FOLDER"/gitconfig     "$HOME"/.gitconfig
echo    "Setup symlinks"

# reload tmux config
tmux source-file ~/.tmux.conf
echo    "Reload tmux config"

# vim
mkdir -p "$HOME"/.vimbackup
mkdir -p "$HOME"/.vimtmp
echo "Setup vim temp"

#!/usr/bin/env bash
set -e

here="$(dirname "$0")"
here="$(cd "$here"; pwd)"

for file in "$here"/*; do
  name="$(basename "$file" .md)"
  [[ $name = bin ]] && dotname="$name" || dotname=".${name}"

  if [[ !( "install readme" =~ $name || -e ~/$dotname || -d $file/.git ) ]]; then
    ln -sfhv ${file#$HOME/} "${HOME}/${dotname}"
  fi
done
