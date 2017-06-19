#!/usr/bin/fish
function notify -d "Send macOS notification with optional text"
    set -l message "Done!"
    set -l timestamp (date "+%y-%m-%d %H:%M:%S")

    if test (count $argv) -gt 0
        set message $argv
    end

    osascript -e "display notification \"$message at $timestamp\" with title \"iTerm\""
end
