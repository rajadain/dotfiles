#!/usr/bin/fish
function listening -d "Find out what is listening on a port"
    lsof -n -i4TCP:$argv[1] | grep LISTEN
end
