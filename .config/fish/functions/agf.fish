#!/usr/bin/fish
function agf -d "Find files with name pattern"
    ag --no-color -g $argv
end
