#!/usr/bin/fish
function vdc -d "Runs docker-compose from inside vagrant"
    if test (count $argv) -lt 1
        echo "vdc runs docker-compose from inside vagrant."
    else
        set -l sargs
        if test (count $argv) -ge 1
            for arg in $argv[1..-1]
                set sargs $sargs \'$arg\'
            end
        end

        vagrant ssh -c "cd /vagrant && docker-compose $sargs"
    end
end
