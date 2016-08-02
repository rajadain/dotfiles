#!/usr/bin/fish
function vhup -d "Halts current vagrant, ups another" 
    if test (count $argv) -lt 1
        echo "Syntax: vhup <project>"
        echo "Must specify project name to switch to."
    else
        set -l project ~/dev/$argv[1]
        if test -f $project/Vagrantfile
            vagrant halt; and cd $project; and vagrant up
        else
            echo "Could not find Vagrant project $project"
        end
    end
end
