#!/usr/bin/fish
function el -d "List files colorfully with git status"
    exa -l --git --icons $argv
end
