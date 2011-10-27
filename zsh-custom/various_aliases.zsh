# easier to read
alias free="free -m"

# pretty cat -- uses pygmentize (python-pygmentize on deb/ubuntu)
alias pcat="pygmentize"

# on this day
alias today="grep -h -d skip `date +%m/%d` /usr/share/calendar/*"

# screenshots
alias screenshot="import -window root ~/`date +%Y%m%d%H%M`.png"

# -h makes the numbers human
alias df="df -h"
alias du="du -h -c"
alias ps="ps"
alias grep="grep --color"

# VNC Server
alias vnc="vncserver -httpport 5900 -geometry 800x600" # start web-accessible vncserver with noted geometry
alias vnck="vncserver -clean -kill" 

# Apache-Ease
# Create aliases for starting and stopping Apache2
alias a2stop="sudo /etc/init.d/apache2 stop"
alias a2start="sudo /etc/init.d/apache2 start"
alias a2restart="sudo /etc/init.d/apache2 restart"
alias a2reload="sudo /etc/init.d/apache2 reload"

# Alias to enter current docs directory
alias docs="cd /Users/dlobraico/Documents/docs/Third\ Year"
alias cmsc="cd /Users/dlobraico/Documents/docs/Third\ Year/CMSC"
alias pbpl="cd /Users/dlobraico/Documents/docs/Third\ Year/PBPL"
alias hcs="cd /Users/dlobraico/sandbox/HCS"
alias sb="cd ~/sandbox"

# set strongest compression level as ‘default’ for gzip
alias gzip="gzip -9n" 

# ping 5 times ‘by default’
alias ping="ping -c 5" 

# Redo command as root
alias redo="sudo \!-1"

# Get readable list of network IPs
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias flush="dscacheutil -flushcache" # Flush DNS cache

# Remove autocorrect for some terms
alias mv="nocorrect mv"         # no spelling correction on mv (zsh FAQ 3.4)
alias cp="nocorrect cp"         # no spelling correction on cp (zsh FAQ 3.4)
alias mkdir="nocorrect mkdir"   # no spelling correction on mkdir (zsh FAQ 3.4)
alias tmux="nocorrect tmux"
alias p4="nocorrect p4"         # prevent zsh from asking me if I mean .. instead of ... ALL of the time.

# Rails and Bundler stuff
alias r="rails"
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
