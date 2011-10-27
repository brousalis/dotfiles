# For ssh
# Migrate these to .ssh/config eventually...
alias s='ssh dj@pyg8.com'
alias scs='ssh dlobraico@ursa.cs.uchicago.edu'
alias sx='ssh -X dj@pyg8.com'
alias cnu='ssh cnuapp@192.168.56.10'
alias cnx='ssh -X cnuapp@192.168.56.10'

alias pbcopy="cat | nc -q1 localhost 2224"
function pbyank {
    cat $1 | pbcopy
}
