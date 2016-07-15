#!/usr/bin/fish
function vdc -d "Runs docker-compose from inside vagrant"
    if test (count $argv) -lt 1
        echo "vdc runs docker-compose from inside vagrant."
    else
        vagrant ssh -c "cd /vagrant && docker-compose $argv"
    end
end
