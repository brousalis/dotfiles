export SHELL="/bin/bash"
export TERM="screen-256color"

export PATH=/usr/local/sbin:${PATH}
export PATH=/usr/local/bin:${PATH}
export PATH=${HOME}/bin:${PATH}

export EDITOR="vim"
export CLICOLOR=1
 
export HISTCONTROL=ignoredups
export HISTSIZE=10000
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

export LESSCHARSET=utf-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# tired of writing this
function include () {
  [[ -f "$1" ]] && source "$1"
}

# load personal settings
include ~/.local

# load settings for specific hostnames
include ~/.hosts/$(ls ~/.hosts | grep $(hostname -s)) 

# load rest of files
for file in ~/.custom/*.sh; do
  source "$file"
done
