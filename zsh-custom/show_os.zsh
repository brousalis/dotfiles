show_os_distro () {
    ## this function is somewhat dependant on the flavor of *nix. i think Linux(tm) is the only
    ## OS that will give less than useful information from "uname -sr".
    exec 2> /dev/null ## suppress errors generated in this function
    [[ ${OSTYPE} == linux* ]] && {
        ## try to figure out the distro with lsb_release. if that fails, look at /proc/version
        lsb_release -sd || {
            read < /proc/version ; print ${${REPLY//*\(/}//[0-9]*}
        }
    } | read 'PR_STUFF[os_name]'
    ## most linux distros should produce useful output from above. for everything else use uname.
    [[ -z "${PR_STUFF[os_name]}" ]] && PR_STUFF[os_name]=$(uname -sr)
    [[ -n "${PR_STUFF[os_name]}" ]] && print -n "(${fg_bold[white]}${${=PR_STUFF[os_name]}[*]}${${terminfo[sgr0]}})"
}

