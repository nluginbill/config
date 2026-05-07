function reap_mcp_orphans --description "Kill orphaned mongodb-mcp-server processes (ppid=1)"
    set -l orphans (ps -axo pid,ppid,command | awk '$2==1 && /mongodb-mcp-server/ {print $1}')
    if test (count $orphans) -gt 0
        kill $orphans 2>/dev/null
        echo "reap_mcp_orphans: killed "(count $orphans)" orphan(s)"
    end
end
