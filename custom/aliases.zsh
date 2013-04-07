# aliases
alias h='cd ~'
alias home='cd ~'
alias dots='cd ~/dotfiles'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
function u() { NUM=${1:-1}; for (( start = 1; start <= $NUM; start++ )); do cd ..; done; }

alias ifi='ifconfig | ack "net"'
alias untar="tar -xvvf"
alias reload="source ~/.zshrc"
alias dsremove="find . -name .DS_Store -print0 | xargs -0 git rm --ignore-unmatch"
alias server='open http://localhost:1337 && python -m SimpleHTTPServer 1337'
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"
alias fs="stat -f '%z bytes'"
alias df="df -h"
alias gs="git status -sb"
alias grm="git ls-files --deleted | xargs git rm"
alias undopush="git push -f origin HEAD^:master"
alias gbcleanup="git branch --merged | grep -v "\*" | xargs -n 1 git branch -d"
alias colors='for i in {0..255} ; do printf "\x1b[38;5;${i}mcolour${i}\n"; done'
alias github="chrome \`git remote -v | grep github.com | grep fetch | head -1 | field 2 | sed 's/git:/http:/g'\`"

# use at the end of a command, ex: ls -la COUNT
alias -g COUNT='| wc -l'
alias -g NULL='2> /dev/null'

# ls
alias ll='ls -la'
alias l1='tree --dirsfirst -ChFL 1'
alias l2='tree --dirsfirst -ChFL 2'
alias l3='tree --dirsfirst -ChFL 3'

export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

if [ -x /usr/bin/dircolors ]; then
  eval "`dircolors -b`"
  alias ls='ls -Gla --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias ack='ack --color'
  alias less='less -R'
  alias diff='colordiff -dw'
fi

# remove autocorrect for some terms
alias mv="nocorrect mv"
alias cp="nocorrect cp"
alias mkdir="nocorrect mkdir"
alias tmux="nocorrect tmux"
alias rake='noglob rake'
alias heroku='noglob heroku'
alias bundle='noglob bundle'

# after a cd, run ls
function chpwd() {
  emulate -LR zsh
  ls -la
}

# find and open files in vim
function vif() {
  vim $(find . -name \*$1\*)
}

# fix git tab completion slowness
__git_files () {
  _wanted files expl 'local files' _files
} 
