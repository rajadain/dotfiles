function __parse_git_branch
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
end

function fish_prompt --description 'Write out the prompt'
    # Just calculate this once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    set -l color_cwd
    set -l suffix
    switch $USER
    case root toor
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        else
            set color_cwd yellow
        end
        set suffix '#'
    case '*'
        set color_cwd yellow
        set suffix '>'
    end

    set -l prompt_pwd (prompt_pwd)
    set -l git_branch (__parse_git_branch)

    set -l left_prompt "$USER@$__fish_prompt_hostname $prompt_pwd $git_branch"
    set -l left_prompt_color (set_color green)"$USER@$__fish_prompt_hostname" (set_color yellow)$prompt_pwd (set_color red)$git_branch

    set -l right_prompt (date "+%y-%m-%d %H:%M:%S")
    set -l right_prompt_color (set_color normal)$right_prompt

    set -l columns (math $COLUMNS - (string length $left_prompt) - (string length $right_prompt) + 27)
    if not test -n "$git_branch"
        set columns (math $columns + 1)
    end

    printf "%s %"$columns"s\n" "$left_prompt_color" "$right_prompt_color"
    echo -s (set_color normal) "$suffix "
end
