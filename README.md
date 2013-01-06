# My dotfiles
This is my ideal setup for a Unix/Linux environment. 

## Features
I use zsh, most specifically the [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) framework. For vim, I use the [janus](https://github.com/carlhuda/janus) framework. I've made custom modifications to each of these, which you can find in `/janus` and `/custom` (for oh-my-zsh). These folders are symlinked upon installation and are loaded with their respective frameworks.

## Setup
Run `rake` inside the repo.

This will execute the automatic installers for Janus and oh-my-zsh, then symlink all of the config files from the repo into your home directory.

## Removal
Run `rake uninstall` inside the repo.

This will remove all of the symlinks and restore any backed up files. 

## Requirements
- `rvm ruby rails`
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
