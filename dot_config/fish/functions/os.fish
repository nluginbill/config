function os --description 'Search Obsidian vault'
    if test (count $argv) -eq 0
        echo "Usage: os <query>"
        return 1
    end
    obsidian search:context query="$argv" 2>/dev/null
end
