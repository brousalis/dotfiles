#!/bin/bash

# zsh
if [ ! -d /bin/zsh ]; then
  curl -L http://install.ohmyz.sh | sh
fi

# brew 
if test ! $(which brew) && "$(uname -s)" == "Darwin"
then
  echo "  Installing Homebrew"
  curl -fsSL https://raw.github.com/mxcl/homebrew/go
  brew update
  brew upgrade
  brew install coreutils moreutils findutils
  brew install git
  brew install bash bash-completion
  brew install vim --override-system-vi
  brew install ack
  brew install node
  brew install imagemagick --with-webp
  brew install pngcheck
  brew install rename
  brew install tree
  brew install tmux
  brew install openssl
  brew install readline
  brew install reattach-to-user-namespace
  brew cleanup
fi

# apt 
if [ "$(uname -s)" != "Darwin" ]
then
  sudo apt-get install build-essential ack vim tmux
fi

# janus
if [ ! -d ~/.vim/bootstrap.sh ]; then
  curl -Lo- https://bit.ly/janus-bootstrap | bash
fi

# rbenv
if test ! $(which rbenv)
then
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
fi

# ruby build
if test ! $(which ruby-build)
then
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

# update vim plugins
git submodule init
git submodule update

# symlink files
sh bootstrap.sh
