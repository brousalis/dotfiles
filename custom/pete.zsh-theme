function prompt_char {
    #echo '↪'
    #echo '⚡'
    #echo '🍺 '
    echo '🌀 '
    #echo '‽'
    #echo '☢'
    #echo '☠'
    #echo '☭'
    #echo '⨁'
    #echo '☣'
    #echo '⚛'
    #echo 'ॐ '
    #echo '↯'
    #echo '☯'
    #echo '☘'
    #echo '人'
}

PROMPT='
%{$fg_bold[cyan]%}$(prompt_char) %{$fg_bold[yellow]%}%d %{$fg_bold[cyan]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}[%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[magenta]%}] %{$fg[yellow]%}‼%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[magenta]%}]"
