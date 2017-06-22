#!/usr/bin/fish
function notify -d "Send macOS notification with optional text"
    set -l message "Done!"
    set -l timestamp (date "+%y-%m-%d %H:%M:%S")

    if test (count $argv) -gt 0
        set message $argv
    end

    terminal-notifier \
        # Disabled until this is fixed:
        # https://github.com/julienXX/terminal-notifier/issues/223
        # -sender "com.googlecode.iterm2" \
        # -activate "com.googlecode.iterm2" \
        # -timeout 60 \
        -title "iTerm" \
        -subtitle "$timestamp" \
        -message "$message"
end
