#######################################################
## set up an array to help facilitate the PROMPT tricks
## the array "PR_STUFF" contains things to be used in the prompt
typeset -A PR_STUFF

######################
## aliases & functions

cd () {
    { unsetopt XTRACE } 2> /dev/null
    emulate -LR zsh
    ## cd to a file (cd to the directory that a file is in).
    ## this _might_ break some zsh specific features of 'cd', but none that i use.
    ## as of 23 oct 2007 i can't see that it breaks anything.
    if [[ 1 == "${#}" && '-' != "${1}" && ! -d "${1}" && -d "${1:h}" && "${1}" != (+|-)<-> ]]
    then
        PR_STUFF[cd_color]=file
        builtin cd "${1:h}"
    else
        [[ "${*}" == '-' ]] && PR_STUFF[cd_color]=dash
        builtin cd "${@}"
    fi
}

cdmkdir () {
    { unsetopt XTRACE } 2> /dev/null
    emulate -LR zsh
    ## create a new directory and cd into it
    mkdir -p "${1}"
    cd "${1}"
}

shellname () {
    { unsetopt XTRACE } 2> /dev/null
    emulate -LR zsh
    ## a *very* simple command to set the SHELL_NAME variable.
    ## used to explicitly set a name for the shell, as displayed in
    ##    title bars, icons, `screen` lists, etc
    ## with no arguments the name returns to normal (dynamic) operation
    SHELL_NAME="${*}"
}
shellprefix () {
    { unsetopt XTRACE } 2> /dev/null
    emulate -LR zsh
    ## like shellname, but just a prefix
    SHELL_PREFIX="${*}"
}

command_title () {
    ### this function sets the current command name in title bars, tabs, and screen lists
    ## inspired by: http://www.semicomplete.com/blog/2006/Jun/29
    if [[ -n ${SHELL_NAME} ]]
    then
        # allow the $cmnd_name to be set manually and override automatic values
        # to set the shell's title to "foo";    export SHELL_NAME=foo
        # to return to normal operation;        unset SHELL_NAME
        cmnd_name="${SHELL_NAME}"
    elif [[ 'fg' == "${${(Qz)@}[1]}" ]]
    then
        # this is a poor hack to replace 'fg' with a more sensical command
        # it really only works properly if only one job is suspended
        cmnd_name="${(qvV)jobtexts}"
    else
        # get the $cmnd_name from the current command being executed
        local cmnd_name="${1}"
    fi
    # make nonprintables visible
    # convert literal newline into "; " & literal tab into space
    cmnd_name="${(QV)${cmnd_name//$'\t'/ }//$'\n'/; }"
    # truncate the $cmnd_name
    cmnd_name="%80>...>${cmnd_name//\%/\%\%}%<<"
    [[ "${USERNAME}" != "${LOGNAME}" ]] && cmnd_name="${USERNAME}: ${cmnd_name}"
    # if the shell is running on an ssh connection, prefix the command with "$HOST: "
    [[ -n "${SSH_CONNECTION}" ]] && cmnd_name="${HOST}: ${cmnd_name}"
    ## add prefix, if defined
    [[ -n "${SHELL_PREFIX}" ]] && cmnd_name="${SHELL_PREFIX}: ${cmnd_name}"
    PR_STUFF[prev_cmnd_name]="${(q)cmnd_name}"
    # don't confuse the display any more than required
    #   we'll put this back, if required, below
    setopt NO_PROMPT_SUBST LOCAL_OPTIONS
    case ${TERM} in
        xterm*)
            print -Pn "\e]0;[${COLORTERM:-${TERM}}] ${(q)cmnd_name}\a" > ${TTY} # plain xterm title & icon name
            ;;
        screen)
            print -Pn "\ek${(q)cmnd_name}\e\\" > ${TTY} # screen title
            ## for best results, see: http://smasher.org/zsh/screenrc
            ## and modify to suit
            ;;
        rxvt*)
            print -Pn "\e]62;[${COLORTERM:-${TERM}}] ${(q)cmnd_name}\a" > ${TTY} # (m)rxvt title & icon name
            print -Pn "\e]61;${(q)cmnd_name}\a" > ${TTY} # mrxvt tab name
            ## there's no good way for the shell to know if it's running in rxvt or mrxvt.
            ## this assumes mrxvt, but shouldn't hurt anything in rxvt.
            ;;
    esac
}

######################
#
#### prompt tricks ### from atomsmasher on dotfiles.org
## not all tricks are available on all terminals
######################
## property  start end
## bold      %B    %b
## underline %U    %u
## standout  %S    %s
PR_STUFF[ITALIC]="%{${terminfo[sitm]}%}"        # enter_italics_mode
PR_STUFF[END_ITALIC]="%{${terminfo[ritm]}%}"    # exit_italics_mode
PR_STUFF[DIM]="%{${terminfo[dim]}%}"            # enter_dim_mode
PR_STUFF[BLINK]="%{${terminfo[blink]}%}"        # enter_blink_mode
PR_STUFF[NO_COLOR]="%{${terminfo[sgr0]}%}"      # exit_attribute_mode (turn off all attributes)

#####################################################
# See if we can use extended characters to look nicer
# more info on all of this funky stuff: "man 5 terminfo"
typeset -A altchar
set -A altchar ${(s..)terminfo[acsc]}
PR_STUFF[SET_CHARSET]="%{${terminfo[enacs]}%}"  # enable_alternate_character_set
PR_STUFF[SHIFT_IN]="%{${terminfo[smacs]}%}"     # enter_alt_charset_mode
PR_STUFF[SHIFT_OUT]="%{${terminfo[rmacs]}%}"    # end_alternate_character_set
typeset -A ACS
ACS[STERLING]=${altchar[\}]:- } # UK pound sign
ACS[DARROW]=${altchar[.]:- }    # arrow pointing down
ACS[LARROW]=${altchar[,]:-<}    # arrow pointing left
ACS[RARROW]=${altchar[+]:->}    # arrow pointing right
ACS[UARROW]=${altchar[-]:-^}    # arrow pointing up
ACS[BOARD]=${altchar[h]:-#}     # board of squares
ACS[BULLET]=${altchar[~]:-#}    # bullet
ACS[CKBOARD]=${altchar[a]:-#}   # checker board (stipple)
ACS[DEGREE]=${altchar[f]:-#}    # degree symbol
ACS[DIAMOND]=${altchar[\`]:-+}  # diamond
ACS[GEQUAL]=${altchar[z]:->}    # greater-than-or-equal-to
ACS[PI]=${altchar['{']:-#}      # greek pi
ACS[HLINE]=${altchar[q]:--}     # horizontal line
ACS[LANTERN]=${altchar[i]:-#}   # lantern symbol
ACS[PLUS]=${altchar[n]:-+}      # large plus or crossover
ACS[LEQUAL]=${altchar[y]:-<}    # less-than-or-equal-to
ACS[LLCORNER]=${altchar[m]:-+}  # lower left corner
ACS[LRCORNER]=${altchar[j]:-+}  # lower right corner
ACS[NEQUAL]=${altchar[|]:-!}    # not-equal
ACS[PLMINUS]=${altchar[g]:-#}   # plus/minus
ACS[S1]=${altchar[o]:-_}        # scan line 1
ACS[S3]=${altchar[p]:-_}        # scan line 3
ACS[S7]=${altchar[r]:-_}        # scan line 7
ACS[S9]=${altchar[s]:-_}        # scan line 9
ACS[BLOCK]=${altchar[0]:-#}     # solid square block
ACS[TTEE]=${altchar[w]:-+}      # tee pointing down
ACS[RTEE]=${altchar[u]:- }      # tee pointing left
ACS[LTEE]=${altchar[t]:- }      # tee pointing right
ACS[BTEE]=${altchar[v]:-+}      # tee pointing up
ACS[ULCORNER]=${altchar[l]:-+}  # upper left corner
ACS[URCORNER]=${altchar[k]:-+}  # upper right corner
ACS[VLINE]=${altchar[x]:-#}     # vertical line

## this makes `less` much more friendly
export LESS_TERMCAP_md="${terminfo[bold]}${fg_bold[white]}"     # bold/ bright
export LESS_TERMCAP_mh="${fg[white]}"           # dim/ half
export LESS_TERMCAP_me="${terminfo[sgr0]}"      # normal (turn off all attributes)
export LESS_TERMCAP_mr="${terminfo[rev]}"       # reverse
export LESS_TERMCAP_mp="${fg[white]}"           # protected
export LESS_TERMCAP_mk="${fg[white]}"           # blank/ invisible
export LESS_TERMCAP_se="${terminfo[sgr0]}"      # standout end
export LESS_TERMCAP_so="${terminfo[rev]}"       # standout
export LESS_TERMCAP_ue="${terminfo[sgr0]}"      # end underline
export LESS_TERMCAP_us="${fg_bold[cyan]}"       # underline
export LESS='MiRJw -z-5 -j15'

## outline startup info if the TERM does fancy alt-chars
[[ ${enable_outline} == 'y' && ( -n "${${terminfo[enacs]}}" || "${#${(V)ACS[HLINE]}}" -gt 1 ) ]] && {
    PR_STUFF[start_bar]="\${(r:$[${COLUMNS}/3]::${ACS[HLINE]}:)}"
    print -P "${terminfo[enacs]}${terminfo[smacs]}${fg_bold[white]}${ACS[ULCORNER]}${PR_STUFF[start_bar]}${terminfo[rmacs]}${terminfo[sgr0]}"
    PR_STUFF[bar_vline]="${terminfo[enacs]}${terminfo[smacs]}${fg_bold[white]}${ACS[VLINE]}${terminfo[rmacs]}${terminfo[sgr0]}"
    print -n "${PR_STUFF[bar_vline]}"
}

