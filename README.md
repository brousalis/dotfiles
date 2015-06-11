Bits and pieces taken from all over GitHub. [Kevin Altman](https://github.com/itsthatguy), [Zach Holman](https://github.com/holman/dotfiles), [Stefan Penner](https://github.com/stefanpenner/dotfiles)

### Install
#### `script/install`

    bash -c "$(curl -fsSL raw.github.com/brousalis/dotfiles/master/script/install)"

**Always** read a script before you curl: [https://github.com/brousalis/dotfiles/blob/master/script/install](https://github.com/brousalis/dotfiles/blob/master/script/install)

This will install:

- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- [rbenv](https://github.com/sstephenson/rbenv)
- [tmux](http://sourceforge.net/projects/tmux/)
- [ruby-build](https://github.com/sstephenson/ruby-build)
- [Vundle](https://github.com/gmarik/Vundle.vim) and vim plugins
- packages via `brew` or `apt` 
- various config files

If the installer finds an existing file when symlinking, it will skip it.

### Uninstall
#### `script/uninstall`

This will remove all of the symlinks and the vim plugins.


### Brew
#### `script/brew`
`script/install` will check for Mac OS X and install brew if it doesn't exist. If it does, it run `script/brew`, update all kegs, and install the following:

    ack
    bash
    bash-completion
    brew-cask
    coreutils
    findutils
    freetype
    geoip
    git
    htop-osx
    hub
    icu4c
    imagemagick
    jpeg
    libevent
    libpng
    libtool
    memcached
    mongodb
    moreutils
    mysql
    node
    openssl
    pkg-config
    pngcheck
    rabbitmq
    readline
    reattach-to-user-namespace
    redis
    rename
    sqlite
    tmux
    trash
    tree
    vim
    webp
    wget
    xz
 

### OSX Settings
#### `script/brew`
I have modified https://github.com/mathiasbynens/dotfiles/blob/master/.osx slightly and included it in the script folder. It is well documented, I recommend going through it. Run `script/osx` after running install.


