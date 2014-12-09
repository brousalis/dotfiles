<a href="#"><img src="http://i.imgur.com/LnekoTL.png" height="300px" width="500px"></a>
<a href="#"><img src="http://i.imgur.com/31ISiil.png" height="300px" width="500px"></a>

### Setup

#### `script/install`

This will install:

- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- [brew](http://brew.sh)
- [rbenv](https://github.com/sstephenson/rbenv)
- [tmux](http://sourceforge.net/projects/tmux/)
- [ruby-build](https://github.com/sstephenson/ruby-build)
- [Janus](https://github.com/carlhuda/janus)
- additional vim plugins
- config files

If the installer finds an existing file when symlinking, it will skip
it.

### Removal
#### `script/unintsall`

This will remove all of the symlinks.

### Brew
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

### Vim plugins
To add more vim plugins, do `git add submodule https://github.com/...` in the `/janus` folder, and they will automatically load the next time you run vim. 

### OSX Settings
I have modified https://github.com/mathiasbynens/dotfiles/blob/master/.osx slightly and included it in the script folder. It is well documented, I recommend going through it. Run `script/osx` after running install.

### Custom terminal
In the `/custom` folder, you'll find my iTerm settings, as well as the font I use: `M Plus 1m` from [M+ Fonts](http://mplus-fonts.sourceforge.jp/). http://www.fontsquirrel.com/fonts/M-1m
