function on --description 'Create and open new note'
    if test (count $argv) -eq 0
        echo "Usage: on <note name>"
        return 1
    end
    obsidian create name="$argv" open 2>/dev/null
end
