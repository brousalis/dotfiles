export ZSH=$HOME/.oh-my-zsh
export ZSHCUSTOM=$HOME/dotfiles/zsh-custom
export ZSH_THEME="random"

plugins=(fasd heroku osx gem rake rails3 ruby git)

source $ZSH/oh-my-zsh.sh

export SHELL='/bin/zsh'
export PATH=/usr/local/sbin:${PATH}
export PATH=/usr/local/bin:${PATH}
export PATH=${HOME}/bin:${PATH}

# zsh settings
setopt auto_resume
setopt bg_nice
setopt autocd
setopt autopushd

setopt glob_complete

setopt bang_hist
setopt hist_ignore_space

autoload -U zrecompile
autoload -U zmv
autoload -U zargs

function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# secrets
source "${HOME}/.personal"
