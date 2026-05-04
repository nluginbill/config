function da --description 'Append to daily note'
    if test (count $argv) -eq 0
        echo "Usage: da <content>"
        return 1
    end
    obsidian daily:append content="$argv" 2>/dev/null
end
