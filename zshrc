ZSH="$HOME/dotfiles/oh-my-zsh"
ZSH_CUSTOM="$HOME/dotfiles/custom"
ZSH_THEME="pete"

plugins=(fasd heroku autojump osx gem rake rails3 ruby git)

source $ZSH/oh-my-zsh.sh

export SHELL='/bin/zsh'
export PATH=/usr/local/sbin:${PATH}
export PATH=/usr/local/bin:${PATH}
export PATH=${HOME}/bin:${PATH}

export HISTCONTROL=ignoredups
export HISTSIZE=10000
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

export GREP_OPTIONS='--color=auto'
export EDITOR='vim'
export CLICOLOR=1

# heroku
export PATH="/usr/local/heroku/bin:$PATH"

# secrets
[ -f ~/.zshrc.local ] && source ${HOME}/.zshrc.local

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LESSCHARSET=utf-8
