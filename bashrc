# pete brousalis
# .bashrc - bash profile

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
function u() { NUM=${1:-1}; for (( start = 1; start <= $NUM; start++ )); do cd ..; done; }

# add stuff to the path
export PATH=/usr/lib:${HOME}/bin:${PATH}
export P4EDITOR='vim'
export EDITOR='vim'
export P4CONFIG=${HOME}/.p4config
export CNUAPP_DIR=/export/web/cnuapp
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

# platform dependent
if [[ $platform = 'linux' ]]; then
  #cnu paths
  export PATH=/cnu/bin:/export/web/cnuapp/lib/service_mgr/bin:${HOME}/cnu-tools/bin:/export/web/bug/172476_sparse/bin:${PATH}
  #cnu tools
  function cnuc() { cd $(cnucd "$@") ;} # find paths based on p4 opened files [deprecated]
  function ccd() { cd $(cnucd "$@") ;}  # find paths based on p4 opened files [deprecated]
  function clog() { tail -fq -n 0 /export/logs/* | grep -v mef | grep -v 'Session data'; } # tail and follow the log for ALL log messages
  function cnuweb() { cnurestart murder; rm /export/web; ln -s $1 /export/web; cnurestart restart; } # change the current /export/web dir
  function spec-start() { cd /export/web/cnuapp/test; ../bin/cnu_env bash; } # start the test environment so we can run tests faster
  function cdb() { cnurestart stop; cnudbrebuild "$@"; cnurestart start; } # rebuild a DB. specify a cluster to start automatically
  function cprv() { cnupromote "$@"; vim "$@"; } # promote a file, edit it, and then open it in vim. use on one file only
  alias sconsole='source /etc/cnu/cnu_env; /export/web/cnuapp/script/console $(echo $RAILS_ENV)' 
  alias cb="cnubugchanges" # see previous log commits to this bug [deprecated]
  alias cch="cnuchange" # pick a current bug number [deprecated]
  alias ce="cnuenv" # change the cluster running and restart lightspeed
  alias ci="cnuinfo" # view client and opened file info [broken]
  alias cm="cnumakebranch" # create a new sparse branch
  alias cpr="cnupromote" # promote a file to the current bug branch
  alias cr="cnurestart" # restart, start, stop, or kill runsv
  alias cs="cnusubmit" # search files for errant tab characters, and submit if your opened files are clear
  alias cw="cnuwait" # check the queue for people currently commiting, integrating, etc
  alias spec='spec -c -fs' # default switches for rspec
  alias p4i='p4 integrate -3dtv' # integrate, plus the 'correct' switches
  alias cg='/export/web/cnuapp/bin/cnu_env cnu_gem'
  # cnu shortcuts
  alias cnu='cd /export/web/comp/stable'
  alias tps='cd /export/web/chelsea/stable/app/svc/iovation'
  alias io='cd /export/web/comp/stable/cnuapp/ruby/svc/iovation'
  alias neph='bugscreen 186670'
elif [[ $platform = 'darwin' ]]; then
  # connect to vm
  alias vmstart='VBoxHeadless --startvm "ASTERISK MOTHERFUCKER" &'
  alias vmstop='VBoxManage controlvm "ASTERISK MOTHERFUCKER" poweroff'
  alias vmssh='ssh cnuapp@192.168.56.3'
fi

# bash completion settings (actually, these are readline settings)
bind "set completion-ignore-case on" # note: bind is used instead of setting these in .inputrc.  This ignores case in bash completion
bind "set bell-style none" # No bell, because it's damn annoying
bind "set show-all-if-ambiguous On" # this allows you to automatically show completion without double tab-ing

# desktop
alias cssh='ssh cnuapp@10.224.23.55'

# aliases
alias h='cd ~'
alias home='cd ~'
alias dots='cd ~/dotfiles'
alias t='vim ~/dotfiles/list.todo'
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
alias rmg="git rm $(git ls-files --deleted)"
alias reload="source ~/.bashrc"

# load rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
