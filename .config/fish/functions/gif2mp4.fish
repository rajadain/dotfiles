#!/usr/bin/fish
function _gif2mp4
	if test (count $argv) -lt 1
        echo "gif2mp4 converts GIF files to MP4 with ffmpeg"
    else
    	for arg in $argv[1..-1]
    		if [ (path extension $arg) != ".gif" ]
    			echo "Skipping $arg since it is not .gif"
    			continue
    		else
    			ffmpeg -i $arg -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" (path change-extension '.mp4' $arg)
    		end
    	end
    end
end

function gif2mp4 -d "Converts GIF files to MP4 with ffmpeg"
	argparse 'd/delete' 'a/autolast' -- $argv

	# --delete will delete the original .gif after successful conversion
	# --autolast will pick the alphabetically most recent .gif

	if set --query _flag_autolast
		set -l MOST_RECENT_GIF (ls *.gif | tail -1)
		
		if _gif2mp4 "$MOST_RECENT_GIF"; and set --query _flag_delete
			rm "$MOST_RECENT_GIF"
		end
	else
		if _gif2mp4 $argv; and set --query _flag_delete
			rm $argv
		end
	end
end
