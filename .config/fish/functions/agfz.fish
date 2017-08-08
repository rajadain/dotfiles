#!/usr/bin/fish
function agfz -d "Interactively find files with name pattern"
    ag --no-color -g "" | fzf
end
