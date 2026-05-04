function otc --description 'Interactive task completion'
    # Get tasks in tsv format: <space>\t<task>\t<file>\t<line>
    # Pipe directly to avoid fish word splitting issues
    set -l selected (obsidian tasks todo format=tsv 2>/dev/null | fzf --delimiter='\t' --with-nth=2 --prompt="Complete task: ")

    if test -z "$selected"
        return 0
    end

    # Parse file (field 3) and line (field 4) from tab-separated selection
    set -l file (echo "$selected" | cut -f3)
    set -l line (echo "$selected" | cut -f4)

    obsidian task path="$file" line="$line" done 2>/dev/null
    echo "Completed task in $file:$line"
end
