#!/usr/bin/fish
function vkj -d "Run scripts from inside vagrant" 
    if test (count $argv) -lt 1
        echo "vkj runs scripts inside vagrant."
        echo "The script must exist in /vagrant/scripts/ inside the VM,"
        echo "and the VM must be up and running."
    else
        set -l script ./scripts/$argv[1].sh
        if test -f $script
            set -l sargs
            if test (count $argv) -ge 2
                set sargs $argv[2..-1]
            end

            vagrant ssh -c "cd /vagrant && $script $sargs"
        else
            echo "Could not find script $script"
        end
    end
end
