# pete brousalis
# .bashrc - bash profile
# terminal color - rgb(2, 37, 56)

# platform detection
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='darwin'
fi

# history
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend
shopt -s checkwinsize

# colorful 
export TERM=xterm-256color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1

YELLOW_GREY="\[\e[33;40m\]"
WHITE_BLACK="\[\e[0m\]"

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
parse_git_branch(){ git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'; }
#export PS1="$YELLOW_GREY[\u.\h:\w]\$[parse_git_branch]>$WHITE_BLACK "
#export PS1='\[\033k\033\\\][\t@drz \w]'
#export PS1='[\t@drz \w]'
#export PS1="$YELLOW_GREY$WHITE_BLACK"
export PS1="\[\033[01;34m\]\h:\[\033[01;33m\]\w\[\033[01;34m\] \$(parse_git_branch)\[\033[01;33m\] >$WHITE_BLACK "
#export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*} [${PWD}]"; echo -ne "\007"'
#export PS1="$YELLOW_GREY\w\[\033[00m\]:\[\033[01;34m\]\$(parse_git_branch)\[\033[00m\] >$WHITE_BLACK "
#export PS1='\[\033k\033\\\][\t@mbp \w]'

# u ..
function bugscreen() { export BUG=$1; screen -R $1; }
function bs() { export BUG=$1; screen -R $1; }
function u() { NUM=${1:-1}; for (( start = 1; start <= $NUM; start++ )); do cd ..; done; }

# add stuff to the path
export PATH=/usr/lib:${HOME}/bin:/opt/local/lib/postgresql83/bin/:/usr/local/bin:${PATH}
export EDITOR='vim'
export P4CONFIG=~/.p4config
export CNUAPP_DIR=/export/web/cnuapp
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

# platform dependent
if [[ $platform = 'linux' ]]; then
  #cnu paths
  export PATH=/cnu/bin:/export/web/stable/cnuapp/bin:/export/web/cnuapp/lib/service_mgr/bin:${HOME}/cnu-tools/bin:/export/web/stable/cabar/bin:/etc/postgresql/8.3/main:${PATH}
  #cnu tools
  function cdb() { cnurestart stop; cnudbrebuild "$@"; cnurestart start; } # rebuild a DB. specify a cluster to start automatically
  alias sconsole='source /etc/cnu/cnu_env; /export/web/cnuapp/script/console $(echo $RAILS_ENV)' 
  alias ce="cnuenv" # change the cluster running and restart lightspeed
  alias cr="cnurestart" # restart, start, stop, or kill runsv
  # cnu shortcuts
  alias cnu='cd /export/web/stable'
  alias neph='bugscreen 186670'
  alias oec='bugscreen 404988'
fi

#vm
alias vmstart='VBoxHeadless --startvm "ASTERISK MOTHERFUCKER" &'
alias vmstop='VBoxManage controlvm "ASTERISK MOTHERFUCKER" poweroff'
alias vmssh='ssh cnuapp@192.168.56.3'

# bash completion settings (actually, these are readline settings)
bind "set completion-ignore-case on" # note: bind is used instead of setting these in .inputrc.  This ignores case in bash completion
bind "set bell-style none" # No bell, because it's damn annoying
bind "set show-all-if-ambiguous On" # this allows you to automatically show completion without double tab-ing

# desktop
alias ossh='ssh cnuapp@10.224.23.55'
alias cssh='ssh cnuapp@10.224.23.10'
alias xen='ssh cnuapp@hades.dev.cashnetusa.com'

# aliases
alias h='cd ~'
alias home='cd ~'
alias dots='cd ~/dotfiles'
alias t='vim ~/dotfiles/list.todo'
alias tl='cat ~/dotfiles/list.todo'
alias gtd='vim ~/dotfiles/list.todo'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'
alias .........='cd ../../../../../../../..'
alias ll='ls -alh'
alias l='ls -alh'
alias ifi='ifconfig | ack "net" '
alias untar="tar -xvvf"
alias gitrem="git ls-files --deleted | xargs git rm"
alias reload="source ~/.bashrc"

# load rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
