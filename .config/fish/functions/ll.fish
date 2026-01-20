#!/usr/bin/fish
function ll -d "List files colorfully with git status"
    eza -l --git $argv
end
