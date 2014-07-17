# My dotfiles
This is my ideal setup for a Unix/Linux environment. I've taken things from all over the place, and I can't guarentee it will work on your machine as well as it does on mine - this is just what works for me.

### Setup

Run `rake` inside the repo. You'll need ruby installed, as well as rbenv. 

This will install Janus, install zsh and oh-my-zsh, sync git submodules for vim plugins (in ~/.janus), then symlink all of the config files from the repo into your home directory.

If the installer finds an existing file when symlinking, it will prompt you to: overwrite it, back it up (moved to a temp folder, which can be restored when 'uninstalling'), or skip it.

NOTE: You can run `rake brew` to install some common brew packages I use. This isn't recommended if you aren't me.

### Removal
Run `rake uninstall` inside the repo.

This will remove all of the symlinks and restore any backed up files.

### Vim plugins
To add more vim plugins, do a `git add submodule https://github.com/...` in the `/janus` folder, and they will automatically load the next time you run vim.
