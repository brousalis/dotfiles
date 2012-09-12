# personal
source ~/dotfiles/personal

# history
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend
shopt -s checkwinsize

# bash completion
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi
GIT_PS1_SHOWDIRTYSTATE=true

if [ -f /opt/local/etc/bash_completion ]; then
  . /opt/local/etc/bash_completion
fi

# git aliases
alias gs='git status'
alias gc='git checkout'
alias gb='git branch'
alias ga='git add'
alias gd='git diff -U10 --color HEAD' 
alias gl='git log'
alias gcb='git checkout -b'

# vi mode
set -o vi
set editing-mode vi
set keymap vi
bind -m vi-insert "\C-n":menu-complete
bind -m vi-insert "\C-p":dynamic-complete-history
bind -m vi-insert "\C-l":clear-screen

# colorful 
#export TERM=xterm-256color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1

if [ -x /usr/bin/dircolors ]; then
  eval "`dircolors -b`"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias ack='ack --color'
  alias less='less -R'
  alias diff='colordiff -dw'
fi

# command line
YELLOW_GREY="\[\e[33;40m\]"
WHITE_BLACK="\[\e[0m\]"

parse_git_branch(){ git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'; }
#export PS1="$YELLOW_GREY[\u.\h:\w]\$[parse_git_branch]>$WHITE_BLACK "
#export PS1='\[\033k\033\\\][\t@drz \w]'
#export PS1='[\t@drz \w]'
#export PS1="$YELLOW_GREY$WHITE_BLACK"
export PS1="\[\033[01;34m\]\h:\[\033[01;33m\]\w\[\033[01;34m\] \$(parse_git_branch) \[\033[01;33m\]>$WHITE_BLACK "
#export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*} [${PWD}]"; echo -ne "\007"'
#export PS1="$YELLOW_GREY\w\[\033[00m\]:\[\033[01;34m\]\$(parse_git_branch)\[\033[00m\] >$WHITE_BLACK "
#export PS1='\[\033k\033\\\][\t@mbp \w]'

# moving up in folders;
function bugscreen() { export BUG=$1; screen -R $1; }
function u() { NUM=${1:-1}; for (( start = 1; start <= $NUM; start++ )); do cd ..; done; }
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# add stuff to the path
export PATH=/usr/lib:${HOME}/bin:/usr/local/bin:${PATH}
export EDITOR='vim'
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

# virtual machines
function vmstart() { 
  VBoxHeadless --startvm "$1" &
}
export -f vmstart
function vmstop { 
  VBoxManage controlvm "$1" savestate
} 
export -f vmstop
alias vmssh='ssh cnuapp@33.33.33.2'

# readline settings
bind "set completion-ignore-case on" 
bind "set bell-style none" 
bind "set show-all-if-ambiguous On" 

# aliases
alias h='cd ~'
alias home='cd ~'
alias dots='cd ~/dotfiles'
alias ll='ls -alh'
alias l='ls -alh'
alias ifi='ifconfig | ack "net"'
alias untar="tar -xvvf"
alias gitrem="git ls-files --deleted | xargs git rm"
alias reload="source ~/.bashrc"
alias dsremove="find . -name .DS_Store -print0 | xargs -0 git rm --ignore-unmatch"
alias server='open http://localhost:1337 && python -m SimpleHTTPServer 1337'
alias rails_new='rails new $1 -m https://raw.github.com/RailsApps/rails-composer/master/composer.rb'

# load rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -r "$HOME/.rvm/scripts/completion" ]] && . "$HOME/.rvm/scripts/completion" 
PATH=$PATH:$HOME/.rvm/bin 
