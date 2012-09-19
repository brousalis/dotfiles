# personal
if [ -f ~/dotfiles/personal ]; then
	. ~/dotfiles/personal
fi

# load files
for file in ~/dotfiles/bash/{bash_prompt,exports,functions,aliases}; do
  [ -r "$file" ] && source "$file"
done
unset file

# completion
[ -f /etc/bash_completion ] && source /etc/bash_completion

# load rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# path
export PATH=/usr/lib:~/bin:/usr/local/bin:~/.rvm/bin:$PATH
