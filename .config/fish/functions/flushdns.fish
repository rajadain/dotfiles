#!/usr/bin/fish
function flushdns -d "macOS: Flushes DNS to get newly propogated changes quicker"
    sudo killall -HUP mDNSResponder
end
