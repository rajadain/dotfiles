#!/usr/bin/env fish

function jsonfmt -d "Sort and format JSON files"
	for arg in $argv[1..-1]
		jq --sort-keys --indent 4 . $arg | sponge $arg
	end
end
