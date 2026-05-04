function oi --description 'Append to inbox note'
    if test (count $argv) -eq 0
        echo "Usage: oi <text>"
        return 1
    end
    obsidian append file="Inbox" content="- $argv" 2>/dev/null
end
