### Setup
Run `script/install` inside the repo.

This will install:

- `oh-my-zsh`
- brew
- rbenv
- tmux
- ruby-build
- Janus
- vim plugins
- config files

If the installer finds an existing file when symlinking, it will skip
it.

### Removal
Run `script/uninstall` inside the repo.

This will remove all of the symlinks.

### Brew
It will update all brew kegs then install the following:

    brew install coreutils moreutils findutils
    brew install git
    brew install bash bash-completion
    brew install vim --override-system-vi
    brew install ack
    brew install node
    brew install imagemagick --with-webp
    brew install pngcheck
    brew install rename
    brew install tree
    brew install tmux
    brew install openssl
    brew install readline
    brew install reattach-to-user-namespace

### Vim plugins
To add more vim plugins, do `git add submodule https://github.com/...` in the `/janus` folder, and they will automatically load the next time you run vim. 
