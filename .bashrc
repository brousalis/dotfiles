#Pete Brousalis
# ~/.bashrc: executed by bash(1) for non-login shells.

# better terminal
export TERM='xterm-256color'

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -la'
alias lk='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias lg='ls -alh | grep'
function vfind() { vim $(find "$@") ;}

# enable programmable completion features
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# ssh + mysql + svn
alias vmssh='ssh cnuapp@192.168.56.2'

# other
alias diff='diff -dw'
alias apt-search='apt-cache search'
alias psql='psql -U postgres'
function bugscreen() { export BUG=$1; screen -R $1; }
function u() { for (( start = 1; start <= $1; start++ )); do cd ..; done; }

# add stuff to the path
export PATH=${PATH}:/usr/lib:${HOME}/bin:/cnu/bin:/export/web/cnuapp/lib/service_mgr/bin
export PATH=${PATH}:/export/bug/172476_sparse/bin

export P4EDITOR='vim'
export EDITOR='vim'
export P4CONFIG=${HOME}/.p4config
export CNUAPP_DIR=/export/web/cnuapp

# cnu tools
function cnuc() { cd $(cnucd "$@") ;} # find paths based on p4 opened files [deprecated]
function ccd() { cd $(cnucd "$@") ;}  # find paths based on p4 opened files [deprecated]
function clog() { tail -fq -n 0 /export/logs/* | grep -v mef | grep -v 'Session data'; } # tail and follow the log for ALL log messages
function cnuweb() { cnurestart murder; rm /export/web; ln -s $1 /export/web; cnurestart restart; } # change the current /export/web dir
function spec-start() { cd /export/web/cnuapp/test; ../bin/cnu_env bash; } # start the test environment so we can run tests faster
function cdb() { cnurestart stop; cnudbrebuild "$@"; cnurestart start; } # rebuild a DB. specify a cluster to start automatically
function cprv() { cnupromote "$@"; vim "$@"; } # promote a file, edit it, and then open it in vim. use on one file only
alias sconsole="/export/web/cnuapp/script/console" # start script console from whatever dir you are in
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

# more colorful versions
alias ack='ack --color'
alias less='less -R'
alias ls='ls --color=auto'
alias grep='grep --color=auto' 
alias diff='colordiff -dw'

# more util shortcuts
alias screens='screen -ls'
alias scs='screen -ls'
alias s='screen -dR'
alias g='grep'
alias pl='p4 login'
alias pc='p4 client'
alias p='p4'
alias po='p4 opened'
alias pe='p4 edit'
alias home='cd ~'
