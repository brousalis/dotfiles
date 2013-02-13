# My dotfiles
This is my ideal setup for a Unix/Linux environment. 

![preview](http://i.imgur.com/Xmo3A35.png)

![preview](http://i.imgur.com/weujQ8H.png)

## Features
I use zsh, most specifically the [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) framework. For vim, I use the [janus](https://github.com/carlhuda/janus) framework. I've made custom modifications to each of these, which you can find in `/janus` and `/custom` (for oh-my-zsh). These folders are symlinked upon installation to the home folder and are loaded with their respective frameworks.

## Setup
Run `rake` inside the repo. 

This will run the automatic installers for Janus and oh-my-zsh, sync the git submodules for several vim plugins (located in /janus), then symlink all of the config files from the repo into your home directory.

## Removal
Run `rake uninstall` inside the repo.

This will remove all of the symlinks and restore any backed up files. 

## Breakdown
Just a heads up, in `aliases.zsh` I have a function at the bottom that modifies `cd` so it automatically runs `ls` when you change into a directory. Remove the line to turn this off.

### iTerm Colors
Load the iTerm color preset through the `Preferences -> Profiles -> Colors`

### Custom hosts and local config
If you add a file to `/hosts` with the hostname of your computer there, that file will automatically loaded.

I have multiple machines and differentiating them by their prompt character. If you're using my custom ZSH theme, you can do:
    function prompt_char {
      echo '♨'
    }

to override the character. 

Also, the file `~/.zshrc.local` is automatically loaded, so you can store any host specific configuration there.

### Tmux keybindings
I use the prefix `Control-a` (C-a) instead of Control-b which is the default. You can blame gnu-screen for that.
    `C-a + R` reload the tmux config
    `F11` previous window
    `F12` next window

You can bind custom commands to tmux by doing:
    bind-key r run-shell "command"

Which can come in handy for restarting services, rebuilding databases, etc...

### Vim keybindings
The name of the colorscheme I use is `herald`. It is quite multicolored. For an easier to read alternative, I recommend `jellybeans`, which is already installed.

I use the following plugins, along with the basic set included in [Janus](https://github.com/carlhuda/janus).
    [ack.vim](http://github.com/mileszs/ack.vim) Use `:Ack` to search the directory using ack-grep and open files directly from there
    [splitjoin.vim](http://github.com/AndrewRadev/splitjoin.vim) Use `zj` and `zk` to split and join lines, useful for CSS refactoring.
    [vim-fugitive](http://github.com/tpope/vim-fugitive) Git plugin, visit the repo to learn more on how to use
    [vim-ruby](http://github.com/vim-ruby/vim-ruby) Ruby plugin, adds some extra flavor
    [vim-surround](http://github.com/tpope/vim-surround) plugin for wrapping text using `cs`, visit the repo and master this plugin.
    [vim-endwise](http://github.com/tpope/vim-endwise) autocompletes certain keywords like 'end' 

These plugins are added in the `/janus` folder and are loaded automatically. They are git submodules, which can be updated by running `git submodule update`

I also use a terrible customized set of keybindings, which you will definitely want to replace with your own. However, if you want to use mine as a starting place, here are some basics:
    `,` leader key
    `;` replaces :
    `,w` toggles word wrap
    `,n` toggles NERDtree
    `,p` opens CtrlP file finder
    `,df` see the diff of the file
    `,ss` strips white space from file
    `zj` splitjoin plugin split line (useful for css)
    `zk` splitjoin plugin join line 
    `Y` go to the end of the line ($)
    `T` go to the beginning of the line (^)
    `K` make a newline from where the cursor is
    `enter` inserts a new line in when in VISUAL mode
    `F1` NERDtree next tab
    `F2` NERDtree previous tab
    `F2 in INSERT` press F2 in INSERT mode to toggle paste indentation
    `F3` move current line up 
    `F4` move current line down
  
### Useful aliases
    `dsremove` finds all .DS_Stores in a folder and removes them
    `server` assuming you have Python installed, runs an HTTP server at localhost:3000
    `rails_new` runs the 'rails-composer' for a new Rails project
    `emptytrash` removes .Trashes on Mac
    `colors` list colors with background used for vim/tmux
    `grm` git removes files already deleted in a git repo
    `github` open github web page of current repo
    `[command] COUNT` add COUNT to the end of a command to run wc -l
    
    All git commands have been shortened as such:
    `gs` git status
    `gb` git branch

## Requirements
- `ruby rails`
- `git ack curl tree tmux vim`

Most of these can be installed by using [brew](http://mxcl.github.com/homebrew/).

## Unicode safe icons
     ✔ ✖ ✘ ✚ ✕ 
     → ➞ ➔ ➜ ➤ ⬆ ⬇ ⬅ ▷ ▽ ▸ ▹ ► ◀ ▲ ▼ ▾ ‣
     ★ ☆ ✩ ✱ ✸ ❉ ✿ ፨ ※ ⁜ ⚙  ✜ ✪ ✦ ◈ ⟐
     ⚑ ⚐ ✆ ✈ ⚠ ⚡ ♪ ♫ ⑆ ❣ ❞ ❝
     ☼ ☀ ☁ ☂ ⚓ ☛ ♻ ♺ ❤ ☯ ☗ ♞ ♛ ♚ ☎ ♨
     ⌘ ⌥ ⌦ ⌫ ↵ ↩ ⇧ ⎋ ⏎ ⎈ ⏏
     ▢ ▣ ▦ ■ ■ ▪ □ ▫ ☐
     ǁ ǂ ʭ Ξ ︴ ┋ ┊ ┇ ┆ ⣿ ⁞ ⡇ ≡ ≣ ⑉ ∵ ∴ ෴
     ⊲ ⊳  ❮ ❯ ‹ › ⟨ ⟩ ⟪ ⟫ ⎨ ⎬ ❪ ❫〔 〕
     ⊕ ⊝ ⊜ ⊗ ⊙ ⊚  ⦿ ⨂ ⨁ ♾ ⨀ ○ ◉ 〇 ◌ ◍ • ●
     〓 █ ▇ ▇ ▇ ▆ ▅ ▅ ▄ ▃ ▂ ▁ ▀▗ ▖ ▘ ▙ ▚ ▛ ▜ ◹ ◺ ◸ ◿
     ➊➋➌➍➎➏➐➑➒➓ ➀➁➂➃➄➅➆➇➈➉ ¹²³⁴⁵⁶⁷⁸⁹⁰ 
