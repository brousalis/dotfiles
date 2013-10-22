# My dotfiles
This is my ideal setup for a Unix/Linux environment. I've taken things from all over the place, and I can't guarentee it will work on your machine as well as it does on mine - this is just what works for me. 

### Setup

Run `rake` inside the repo. 

This will install Janus, install zsh and oh-my-zsh, sync git submodules for vim plugins (in ~/.janus), then symlink all of the config files from the repo into your home directory.

If the installer finds an existing file when symlinking, it will prompt you to: overwrite it, back it up (moved to a temp folder, which can be restored when 'uninstalling'), or skip it. 

NOTE: You can run `rake brew` to install some common brew packages I use. This isn't recommended if you aren't me.

### Removal
Run `rake uninstall` inside the repo.

This will remove all of the symlinks and restore any backed up files. 

### Vim plugins
To add more vim plugins, do a `git add submodule https://github.com/...` in the `/janus` folder, and they will automatically load the next time you run vim.

### Multiple hosts
If you install these dotfiles on multiple hosts, you can put specific
local config settings in `~/.localrc` and they will be loaded.

You can also add a file inside of the `/hosts` folder to do this. If you're using the `pete` zsh theme, you can customize the color of the prompt based on hostname in that file as well. See my 'prometheus' file for an example. 
