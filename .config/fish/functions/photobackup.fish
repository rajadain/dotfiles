function photobackup --description 'Syncs year-dated photo folders to external SSD using rclone'
    # Define the source and destination for readability
    set src ~/Pictures/
    set dest /Volumes/PortableSSD/Stuff/Photos/US/
    set filter_file ~/.config/rclone/filters.txt

    # Check if the destination drive is actually mounted before starting
    if not test -d "$dest"
        set_color red
        echo "Error: External SSD not found at $dest"
        set_color normal
        return 1
    end

    # Run the rclone copy
    # $argv allows you to pass extra flags, e.g., 'photobackup --dry-run'
    rclone copy $src $dest \
        --filter-from $filter_file \
        -P \
        $argv
end
