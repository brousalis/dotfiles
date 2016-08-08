Bits and pieces taken from all over GitHub. [Kevin Altman](https://github.com/itsthatguy), [Zach Holman](https://github.com/holman/dotfiles), [Stefan Penner](https://github.com/stefanpenner/dotfiles)

### Install
#### `script/install`

    bash -c "$(curl -fsSL raw.github.com/brousalis/dotfiles/master/script/install)"

Always read a script before you curl: [https://github.com/brousalis/dotfiles/blob/master/script/install](https://github.com/brousalis/dotfiles/blob/master/script/install)

This will install:

- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- [rbenv](https://github.com/sstephenson/rbenv)
- [tmux](http://sourceforge.net/projects/tmux/)
- [ruby-build](https://github.com/sstephenson/ruby-build)
- [vundle](https://github.com/gmarik/Vundle.vim) and vim plugins
- various config files

If the installer finds an existing file when symlinking, it will skip it.

### Uninstall
#### `script/uninstall`

This will remove all of the symlinks and the vim plugins.
