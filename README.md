# My dotfiles
This is my ideal setup for a Unix/Linux environment. I've taken things from all over the place, and I can't guarentee it will work on your machine as well as it does on mine - this is just what works for me. 

![preview](http://i.imgur.com/weujQ8H.png)
![preview](http://i.imgur.com/Xmo3A35.png)

### Setup
Run `rake` inside the repo. 

This will run the installers for Janus, sync the git submodules for several vim plugins (located in /janus), then symlink all of the config files from the repo into your home directory.

If the installer finds an existing file when symlinking, you can overwrite it, back it up (moved to a temporary folder, which can be restored by 'uninstalling'), or skip it. I cannot remember where I found this rake task from, but credit goes to a dotfiles repo on Github.

### Removal
Run `rake uninstall` inside the repo.

This will remove all of the symlinks and restore any backed up files. 

***

## Breakdown
A quick heads up, in `bashrc` I have a function at the bottom that modifies the `cd` command so it automatically runs `ls` (lists the files) when you change into a directory. Remove the function to turn this off.

### Useful aliases
<pre>
dsremove           |     removes all .DS_Stores in a folder
server             |     assuming you have Python installed, runs a HTTP server (localhost:1337) from the folder
rails_new          |     runs the 'rails-composer' for a new Rails project
emptytrash         |     removes .Trashes on Mac
colors             |     list xterm colors with a preview used for vim/tmux
grm                |     git removes files already deleted in a git repo
github             |     open github web page of current repo (in Chrome)
[command] COUNT    |     add COUNT to the end of a command to pipe wc -l
</pre>

All git commands have been shortened like such:
<pre>
gs  |  git status
gb  |  git branch
</pre>

### Vim keybindings
The name of the colorscheme I use is `herald`. It is quite flamboyant. For an easy to read alternative, I recommend `jellybeans`, which is already installed.

I use the following plugins, along with the basic set included in [Janus](https://github.com/carlhuda/janus).
* [ack.vim](http://github.com/mileszs/ack.vim) - Use `:Ack` to search the directory using ack-grep and open files directly from there
* [splitjoin.vim](http://github.com/AndrewRadev/splitjoin.vim) - Use `zj` and `zk` to split and join lines, useful for CSS refactoring.
* [vim-fugitive](http://github.com/tpope/vim-fugitive) - Git plugin, visit the repo to learn more on how to use
* [vim-ruby](http://github.com/vim-ruby/vim-ruby) - Ruby plugin, adds some extra flavor
* [vim-surround](http://github.com/tpope/vim-surround) - plugin for wrapping text using `cs`, visit the repo and master this plugin.
* [vim-endwise](http://github.com/tpope/vim-endwise) - autocompletes certain keywords like 'end' 

These plugins are added in the `/janus` folder (symlinked to ~/.janus) and are loaded automatically. They are git submodules, which can be updated by running `git submodule update`

I also use a terrible customized set of keybindings, which you will definitely want to replace with your own. However, if you want to use mine as a starting place, here are some basics:
<pre>
,       |    leader key
;       |    replaces :
,w      |    toggles word wrap
,n      |    toggles NERDtree
,p      |    opens CtrlP file finder
,df     |    see the diff of the file
,ss     |    strips white space from file
zj      |    splitjoin plugin split line (useful for css)
zk      |    splitjoin plugin join line 
Y       |    go to the end of the line ($)
T       |    go to the beginning of the line (^)
K       |    make a newline from where the cursor is
enter   |    inserts a new line in when in VISUAL mode
F1      |    NERDtree next tab
F2      |    NERDtree previous tab
F2      |    press F2 in INSERT mode to toggle paste indentation
F3      |    move current line up 
F4      |    move current line down
</pre>

### Tmux keybindings
I use the prefix `Control-a` (C-a) instead of Control-b which is the default. You can blame gnu-screen for that.
<pre>
C-a + R   |    reload the tmux config
F11       |    previous window
F12       |    next window
</pre>
You can bind custom commands to tmux by doing:
<pre>
bind-key r run-shell "command"
</pre>
Which can come in handy for restarting services, rebuilding databases, etc...

### iTerm Colors
Load the iTerm color preset through the `Preferences -> Profiles -> Colors`

### Custom hosts and local config
If you add a file to `/hosts` with the hostname of your computer there, that file will automatically loaded.

I have multiple machines and differentiating them by their prompt character. If you're using my custom ZSH theme, you can do:
<pre>
function prompt_char {
  echo '♨'
}
</pre>

to override the character. 

Also, the file `~/.local` is automatically loaded, so you can store any host specific configuration there.

## Requirements
- `ruby rails`
- `git ack curl tree tmux vim`

Most of these can be installed by using [homebrew](http://mxcl.github.com/homebrew/).

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
