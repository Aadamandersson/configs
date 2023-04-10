function fish_prompt
    set_color brblack
    echo -n "["(date "+%H:%M")"] "
    set_color blue
    echo -n (prompt_pwd)
    echo -n '> '
    set_color normal
end
