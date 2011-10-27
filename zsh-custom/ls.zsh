## turn on colors for ls
if { ls --color=auto -- ${HOME} &> /dev/null }
then
    ## looks like gnu-ls
    ls () { command ls --color=auto ${@} }
else
    [[ ${OSTYPE} == freebsd* || ${OSTYPE} == darwin* ]] && export CLICOLOR=yes LSCOLORS=ExGxFxdxCxDxDxhbadacec
fi

# ls
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias lh='ls -lah'                # human readable (sizes) long and all ;-)
alias lls='ls -l -h -g -F --color=auto'
alias lc='ls -aCF'
alias lsam='ls -am'               # List files horizontally
alias lr='ls -lR'                 # recursive
alias lsx='ls -ax'                # sort right to left rather then in columns
alias lss='ls -shAxSr'            # sort by size
alias lt='ls -lAtrh'              # sort by date and human readable
alias lm='ls -al |more'           # pipe through 'more'

