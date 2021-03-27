#!/usr/bin/fish
function imgview -d "kitty: Show image inline"
    kitty +kitten icat $argv
end
