function dt --description 'Add task to daily note'
    if test (count $argv) -eq 0
        echo "Usage: dt <task description>"
        return 1
    end
    obsidian daily:append content="- [ ] $argv" 2>/dev/null
end
