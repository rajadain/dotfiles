#!/usr/bin/fish
function dsf -d "Fancy colorful diffs"
    diff -u $argv | colordiff | diff-so-fancy | less --tabs=4 -R
end
