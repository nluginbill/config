function om --description 'Create meeting note from template'
    if test (count $argv) -eq 0
        echo "Usage: om <meeting name>"
        return 1
    end
    set -l today (date +%Y-%m-%d)
    obsidian create path="meetings/$argv $today.md" template="Meeting" open 2>/dev/null
end
