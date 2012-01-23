#!/bin/bash

SOURCE="deb http://ftp.de.debian.org/debian sid main"
UPGRADE=false

# check for sources
if grep -Fxq "$SOURCE" /etc/apt/sources.list
then
  echo "DE Debian exists"
else
  echo "Adding DE Debian to apt sources"
  echo $SOURCE >> /etc/apt/sources.list
  $UPGRADE=true
fi

if $UPGRADE=true
then
  sudo apt-get update
fi

# install vim
sudo apt-get remove vim-common vim-runtime vim-gtk vim-gui-common
sudo apt-get install vim-common vim-runtime
