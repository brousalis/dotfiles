#!/usr/bin/env bash

cd "$(dirname "$0")/.."

DOTFILES_ROOT=$(pwd)
DOTFILES_CUSTOM=$(pwd)/custom
SPECTACLE="com.divisiblebyzero.Spectacle.plist"

echo '  Installing Spectacle hotkeys'
mv ~/Library/Preferences/$SPECTACLE ~/Library/Preferences/$SPECTACLE.backup
ln -s $DOTFILES_CUSTOM/$SPECTACLE ~/Library/Preferences/$SPECTACLE

echo '  Installing M+ 2m (mplus-2m-regular) font'
\cp -rv $DOTFILES_CUSTOM/mplus-2m-regular.ttf ~/Library/Fonts

echo '  Installing custom iTerm colors'
open $DOTFILES_CUSTOM/iterm.itermcolors

