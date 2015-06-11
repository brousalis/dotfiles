Bits and pieces taken from all over GitHub. [Kevin Altman](https://github.com/itsthatguy), [Zach Holman](https://github.com/holman/dotfiles), [Stefan Penner](https://github.com/stefanpenner/dotfiles)

### Setup

Run this:

    bash -c "$(curl -fsSL raw.github.com/brousalis/dotfiles/master/script/install)"

### Install
#### `script/install`

This will install:

- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- [rbenv](https://github.com/sstephenson/rbenv)
- [tmux](http://sourceforge.net/projects/tmux/)
- [ruby-build](https://github.com/sstephenson/ruby-build)
- [Vundle](https://github.com/gmarik/Vundle.vim) and my vim plugins
- packages via `brew` or `apt` 
- various config files

If the installer finds an existing file when symlinking, it will skip it.


### Uninstall
#### `script/uninstall`

This will remove all of the symlinks, except `.gitconfig` (just to be safe), and remove the vim plugins.


### Brew
#### `script/brew`
`script/install` will check for Mac OS X and install brew if it doesn't exist. If it does, it update all brew kegs then install the following:

    coreutils 
    moreutils 
    findutils
    git
    bash 
    bash-completion
    vim --override-system-vi
    ack
    node
    imagemagick --with-webp
    pngcheck
    rename
    tree
    tmux
    openssl
    readline
    reattach-to-user-namespace

You can run this functionality separately as `script/brew`.


### OSX Settings
I have modified https://github.com/mathiasbynens/dotfiles/blob/master/.osx slightly and included it in the script folder. It is well documented, I recommend going through it. Run `script/osx` after running install.


