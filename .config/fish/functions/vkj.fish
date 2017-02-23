#!/usr/bin/fish
function vkj -d "Run scripts from inside vagrant"
    if test (count $argv) -lt 1
        echo "vkj runs scripts inside vagrant."
        echo "The script must exist in /vagrant/scripts/ inside the VM,"
        echo "and the VM must be up and running."
    else
        set -l script ./scripts/$argv[1]
        if not test -f $script
            set script $script.sh
            if not test -f $script
                echo "Could not find script $script"
                exit 1
            end
        end

        set -l sargs
        if test (count $argv) -ge 2
            for arg in $argv[2..-1]
                set sargs $sargs \'$arg\'
            end
        end

        vagrant ssh -c "cd /vagrant && $script $sargs"
    end
end
