alias gl='git pull'
alias ga='git add'
alias gp='git push'
alias gd='git diff'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gch='git checkout HEAD~2 --' 
alias gb='git branch -v'
alias gs="git status -sb"
alias grm="git ls-files --deleted | xargs git rm"
alias undopush="git push -f origin HEAD^:master"

function gco {
  if [ $# -eq 0 ]; then
    git checkout master
  else
    git checkout "$@"
  fi
}

# completion with git aliases
__git_complete gco _git_checkout