HOSTNAME="$(hostname)"
LOCATION="/export/private/dotfiles"

ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$LOCATION/custom"
ZSH_THEME="pete"

# zsh settings
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

setopt auto_cd
setopt auto_pushd
autoload -Uz compinit && compinit

plugins=(fasd heroku autojump osx gem rake rails3 ruby git)

source $ZSH/oh-my-zsh.sh

# shell variables
export SHELL="/bin/zsh"
export TERM="screen-256color"

export PATH=/usr/local/heroku/bin:$PATH #  heroku toolbelt
export PATH=/usr/local/sbin:${PATH}
export PATH=/usr/local/bin:${PATH}
export PATH=${HOME}/bin:${PATH}

export HISTCONTROL=ignoredups
export HISTSIZE=10000
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

export EDITOR="vim"
export CLICOLOR=1

export LESSCHARSET=utf-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# load up tmux for every shell
# if [ "$TMUX" = "" ]; then tmux attach; fi

# load personal settings
[ -f ~/.zshrc.local ] && source ${HOME}/.zshrc.local

# load settings for specific hostnames
if [[ -a ${LOCATION}/hosts/${HOSTNAME} ]]; then
 source ${LOCATION}/hosts/${HOSTNAME}
fi
