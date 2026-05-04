function otag --description 'Search tag and open in nvim'
    if test (count $argv) -eq 0
        echo "Usage: otag <tag>"
        return 1
    end

    set -l tag $argv[1]
    # Add # if not provided
    if not string match -q '#*' $tag
        set tag "#$tag"
    end

    set -l vault_path (obsidian vault info=path 2>/dev/null)

    # Search for tag, format: file:line: content
    set -l selected (obsidian search:context query="$tag" 2>/dev/null | fzf --delimiter=':' --with-nth=3.. --prompt="$tag: ")

    if test -z "$selected"
        return 0
    end

    # Parse file and line
    set -l file (echo $selected | cut -d':' -f1)
    set -l line (echo $selected | cut -d':' -f2)

    v "+$line" "$vault_path/$file"
end
