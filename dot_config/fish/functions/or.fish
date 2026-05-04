function or --description 'Open recent file in Obsidian'
    set -l selected (obsidian recents 2>/dev/null | fzf --prompt="Recent: ")

    if test -z "$selected"
        return 0
    end

    obsidian open file="$selected" 2>/dev/null
end
