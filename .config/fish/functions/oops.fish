function oops
    # Get the last command executed (excluding the 'oops' command itself)
    set -l last_cmd $history[1]
    
    if test -n "$last_cmd"
        # Delete it from the history file
        history delete --exact --case-sensitive "$last_cmd"
        echo "Erased '$last_cmd' from history."
    else
        echo "No history found."
    end
end
