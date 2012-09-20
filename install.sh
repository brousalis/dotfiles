#!/bin/bash

FOLDER="$HOME"/dotfiles

# install vim, maybe
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
ln -sf  "$FOLDER"/tmuxinator    "$HOME"/.tmuxinator
ln -sf  "$FOLDER"/screenrc      "$HOME"/.screenrc
ln -sf  "$FOLDER"/tmuxconf      "$HOME"/.tmux.conf
ln -sf  "$FOLDER"/gemrc         "$HOME"/.gemrc
ln -sf  "$FOLDER"/irbrc         "$HOME"/.irbrc
ln -sf  "$FOLDER"/gitconfig     "$HOME"/.gitconfig
ln -sf  "$FOLDER"/gitmodules    "$HOME"/.gitmodules
echo    "Setup symlinks"

# init submodules for pathogen
git pull origin master
git submodule init
git submodule update

# reload tmux config
tmux source-file ~/.tmux.conf
echo    "Reload tmux config"

# vim
mkdir -p "$HOME"/.vimbackup
mkdir -p "$HOME"/.vimtmp
echo "Setup vim temp"
