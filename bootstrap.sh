#!/bin/bash

# platform
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='darwin'
fi
 
FOLDER=$HOME/Dropbox/dotfiles

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

# dropbox
if [[ $platform = 'linux' ]]; then
  sudo cp dropbox.sh /etc/init.d/dropbox
  sudo chmod +x /etc/init.d/dropbox
  sudo update-rc.d dropbox defaults
fi
