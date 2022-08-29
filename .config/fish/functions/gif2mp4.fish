#!/usr/bin/fish
function gif2mp4 -d "Converts GIF files to MP4 with ffmpeg"
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
