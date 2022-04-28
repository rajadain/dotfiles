#!/usr/bin/fish
function ll -d "List files colorfully with git status"
    exa -l --git $argv
end
