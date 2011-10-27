These are my commandline confirguation files. Mainly revolve around configuring zsh, vim, and tmux correctly. Here is a quickie to get started:

    cd ~
    git clone <repo> dotfiles
    cd dotfiles
    git submodule init
    git submodule update
    ./bootstrap.sh

Bootstrap sets up symlinks to the home folder for all of the config files. Pull the git repo to update all of the files. 
