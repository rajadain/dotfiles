## git prompt
function parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

RED="\[\033[0;31m\]"
GRN="\[\033[0;32m\]"
YLW="\[\033[0;33m\]"
GRY="\[\033[0;0m\]"

PS1="$GRN\u@\h:$YLW\w$RED\$(parse_git_branch)\n$GRY\$ "
