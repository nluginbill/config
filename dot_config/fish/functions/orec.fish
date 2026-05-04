function orec --description 'Open recent file in nvim'
    set -l selected (obsidian recents 2>/dev/null | fzf --prompt="Recent: ")

    if test -z "$selected"
        return 0
    end

    set -l vault_path (obsidian vault info=path 2>/dev/null)
    v "$vault_path/$selected"
end
