export ZSH=$HOME/dotfiles/oh-my-zsh
export ZSH_THEME="random"

plugins=(fasd heroku osx gem rake rails3 ruby git)

source $ZSH/oh-my-zsh.sh

export SHELL='/bin/zsh'
export PATH=/usr/local/sbin:${PATH}
export PATH=/usr/local/bin:${PATH}
export PATH=${HOME}/bin:${PATH}

# secrets
[ -f ~/.zshrc.local ] && source ${HOME}/.zshrc.local
