# Mac OS X Only
if [[ $OSTYPE == darwin* ]]; then
    # Open a man file in Skim
    manp()
    {
          man -t "${1}" | open -f -a Skim
    }
    # Read a text file from the commandline in Skim
    catskim()
    {
          cat "${1}" | enscript -p - | open -f -a Skim
    }

    # vim --> mvim
    #alias vim=mvim
    alias vim="~/Applications/MacVim.app/Contents/MacOS/Vim"

    # Quit an OS X application from the command line
    quit () {
        for app in $*; do
            osascript -e 'quit app "'$app'"'
        done
    }
    # Relaunch an OS X application from the command line
    relaunch () {
        for app in $*; do
            osascript -e 'quit app "'$app'"';
            sleep 2;
            open -a $app
        done
    }
    alias stfu="osascript -e 'set volume output muted true'"
    alias pumpitup="sudo osascript -e 'set volume 10'"
    # preview a file using QuickLook
    alias ql="qlmanage -p 2>/dev/null" 
    # Airport Utility
    alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport" 

    export PATH=/usr/local/cuda/bin:$PATH
    export DYLD_LIBRARY_PATH=/usr/local/cuda/lib:$DYLD_LIBRARY_PATH
fi
