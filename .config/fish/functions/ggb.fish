function ggb -d "git grep + git blame"
    set -l IFS :
    command git grep -En $argv[1] | while read -l file line code
        git blame -f -L $line,$line $file | grep -E --color "$argv[1]|\$"
    end
end
