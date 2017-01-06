npm -g install asar
asar e /Applications/Atom.app/Contents/Resources/app.asar /tmp/atomasar
vim /tmp/atomasar/src/main-process/atom-window.js
asar p /tmp/atomasar /Applications/Atom.app/Contents/Resources/app.asar
rm -rf /tmp/atomasar

