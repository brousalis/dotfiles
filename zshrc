export ZSH=$HOME/.oh-my-zsh

#export ZSH_THEME="mrtazz"
export ZSH_THEME="miloshadzic"
#export ZSH_THEME="sunaku"

plugins=(brew git osx ruby ssh-agent vi-mode pip cap rails bundler compleat deb gem github perl rails3 ruby rvm svn vagrant)

source $ZSH/oh-my-zsh.sh

# check the platform
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='darwin'
fi

# vim bindings
bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward

# environment variables
export DYLD_LIBRARY_PATH="/usr/local/mysql/lib:$DYLD_LIBRARY_PATH"
export SHELL='/bin/zsh'
export PATH=/usr/local/sbin:${PATH}
export PATH=/usr/local/bin:${PATH}
export PATH="${HOME}/.cabal/bin:${PATH}" # haskell
export PATH=${HOME}/bin:${PATH}
export PYTHONPATH=$PYTHONPATH:/Users/dlobraico/Library/Python/2.7/site-packages # python
export MANPATH=${MANPATH:-}:/usr/local/man 
export GREP_OPTIONS='--color=auto'
export HISTSIZE=1000
export HISTFILESIZE=1000
export HISTCONTROL=erasedups
export CLICOLOR="True" 
export CC=/usr/bin/gcc-4.2

setopt auto_resume
setopt bg_nice
setopt autocd
setopt autopushd

setopt glob_complete

setopt bang_hist
setopt hist_ignore_space

autoload -U zrecompile
autoload -U zmv

function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# for perforce
export P4CONFIG="${HOME}/.p4config"

# platform specific stuff
if [[ $platform != 'darwin' ]]; then
    export EDITOR='vim'
fi

# for debian box
if [[ $platform = 'linux' ]]; then
    # add stuff to the path
    export PATH=${PATH}:/usr/lib:${HOME}/bin:/cnu/bin:/export/web/cnuapp/lib/service_mgr/bin:${HOME}/cnu-tools/bin:/export/web/bug/172476_sparse/bin
    export PATH=/cnu/bin:/export/web/cnu/chelsea/stable/vendor/bin:$PATH:/home/cnuapp/.gem/ruby/1.8/bin
    export GEM_HOME=/export/web/cnu/chelsea/stable/vendor:/home/cnuapp/.gem/ruby/1.8/bin/rspec
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

    # util shortcuts
    alias pl='p4 login'
    alias pc='p4 client'
    alias p='p4'
    alias po='p4 opened'
    alias pe='p4 edit'
elif [[ $platform = 'freebsd' || $platform == 'darwin' ]]; then
    alias ls='ls -G'
fi

# mac specific
if [[ $platform = 'darwin' ]]; then
    export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
fi

# alises
alias vmstartd='VBoxHeadless --startvm "Dev" &'
alias vmstart='VBoxHeadless --startvm "ASTERISK MOTHERFUCKER" &'
alias vmstopd='VBoxManage controlvm "Dev" poweroff'
alias vmstop='VBoxManage controlvm "ASTERISK MOTHERFUCKER" poweroff'
alias vmsshd='ssh cnuapp@192.168.56.2'
alias vmssh='ssh cnuapp@192.168.56.3'
alias g='grep -i'
alias f='find . -iname'
alias ll='ls -hl'
alias ..='cd ..'
alias ...='cd ../..'

alias reload=". ~/.zshrc"
alias timestamp="date '+%s'"
 
# bash rc  
export TERM=xterm-color
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

# other
function u() { NUM=${1:-1}; for (( start = 1; start <= $NUM; start++ )); do cd ..; done; }
