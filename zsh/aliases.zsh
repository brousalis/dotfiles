alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
function u() { NUM=${1:-1}; for (( start = 1; start <= $NUM; start++ )); do cd ..; done; }

# aliases
alias h='cd ~'
alias home='cd ~'
alias dots='cd ~/dotfiles'
alias r='rails'
alias ifi='ifconfig | ack "net"'
alias untar="tar -xvvf"
alias reload="source ~/.bashrc"
alias dsremove="find . -name .DS_Store -print0 | xargs -0 git rm --ignore-unmatch"
alias server='open http://localhost:1337 && python -m SimpleHTTPServer 1337'
alias rails_new='rails new $1 -m https://raw.github.com/RailsApps/rails-composer/master/composer.rb'
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"
alias cheftar="rm chef.tar.gz && tar -czvf chef.tar.gz --exclude=.git --exclude=.ssh --exclude=.DS_Store ."  
alias fs="stat -f '%z bytes'"
alias df="df -h"
alias grm="git ls-files --deleted | xargs git rm"
alias undopush="git push -f origin HEAD^:master"

# ls
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias lh='ls -lah'                # human readable
alias lsam='ls -am'               # list files horizontally
alias lr='ls -lR'                 # recursive
alias lsx='ls -ax'                # sort right to left rather then in columns
alias lss='ls -shAxSr'            # sort by size
alias lt='ls -lAtrh'              # sort by date and human readable
alias lm='ls -al |more'           # pipe through 'more'
alias lls='ls -l -h -g -F --color=auto'
alias lc='ls -aCF'

# pretty ways to look at directory contents
alias l1='tree --dirsfirst -ChFL 1'
alias l2='tree --dirsfirst -ChFL 2'
alias l3='tree --dirsfirst -ChFL 3'

alias ll1='tree --dirsfirst -ChFupDaL 1'
alias ll2='tree --dirsfirst -ChFupDaL 2'
alias ll3='tree --dirsfirst -ChFupDaL 3'

alias l='l1'
alias ll='ll1'

# Remove autocorrect for some terms
alias mv="nocorrect mv"
alias cp="nocorrect cp"
alias mkdir="nocorrect mkdir"
alias tmux="nocorrect tmux"
