#!/bin/bash

FOLDER=$HOME/dotfiles

# install vim
source vim.sh

# dotfiles
cd      $FOLDER
ln -sf  $FOLDER/vimrc         $HOME/.vimrc
ln -sf  $FOLDER/bashrc        $HOME/.bashrc
ln -sf  $FOLDER/bash_profile  $HOME/.bash_profile
ln -sf  $FOLDER/vim           $HOME/.vim
ln -sf  $FOLDER/screenrc      $HOME/.screenrc
ln -sf  $FOLDER/gitconfig     $HOME/.gitconfig

# vim
mkdir -p $HOME/.vimbackup
mkdir -p $HOME/.vimtmp
