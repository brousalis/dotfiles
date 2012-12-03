# secrets
[ -f ~/dotfiles/personal ] && source ~/dotfiles/personal

# completion
[ -f /etc/bash_completion ] && source /etc/bash_completion

# load
for file in ~/dotfiles/bash/{prompt,exports,functions,aliases}; do
  [ -r "$file" ] && source "$file"
done
unset file
