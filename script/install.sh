#!/bin/bash

DOTFILES_ROOT="${HOME}/.dotfiles"
DOTFILES_REPO="git@github.com:brousalis/dotfiles.git"

if [[ ! -d ${DOTFILES_ROOT} ]]; then
  git clone ${DOTFILES_REPO} ${DOTFILES_ROOT}
fi

cd ${DOTFILES_ROOT}

# rbenv
[ ! -d "$HOME/.rbenv" ] && git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

# ruby build
[ ! -d "$HOME/.rbenv/plugins/ruby-build" ] && git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# zsh
[ ! -d "$HOME/.oh-my-zsh" ] && curl -L http://install.ohmyz.sh | sh

# install vundle 
git submodule update --init --recursive

# symlink files
script/bootstrap

# vim plugins
vim +PluginInstall +qa

# switch shell to zsh
if [ $SHELL != '/bin/zsh' ]; then
	chsh -s /bin/zsh
fi
