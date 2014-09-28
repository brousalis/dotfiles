# My dotfiles
This is my ideal setup for a Unix/Linux environment. I've taken things from all over the place, and I can't guarentee it will work on your machine as well as it does on mine - this is just what works for me.

### Setup
Run `rake` inside the repo. 

This will install Janus, sync git submodules for vim plugins (in ~/.janus), then symlink all of the config files from the repo into your home directory.

If the installer finds an existing file when symlinking, it will prompt you to: overwrite it, back it up (moved to a temp folder, which can be restored when 'uninstalling'), or skip it.

### Removal
Run `rake uninstall` inside the repo.

This will remove all of the symlinks and restore any backed up files.

### Brew
You can run `rake brew` which will install all the packages listed
in the `Brewfile`. Not recommended.

### Vim plugins
To add more vim plugins, do a `git add submodule https://github.com/...` in the `/janus` folder, and they will automatically load the next time you run vim.
