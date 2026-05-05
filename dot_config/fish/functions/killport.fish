function killport --description 'Kill any process(es) listening on the given port (shows parent for spotting supervisors)'
    if test (count $argv) -eq 0
        echo "usage: killport <port>" >&2
        return 2
    end

    set -l port $argv[1]
    set -l pids (lsof -ti :$port)

    if test -z "$pids"
        echo "no process listening on port $port"
        return 1
    end

    echo "found pid(s) on port $port:"
    for pid in $pids
        set -l info (ps -o ppid=,comm= -p $pid 2>/dev/null | string trim)
        set -l ppid (echo $info | awk '{print $1}')
        set -l cmd (echo $info | cut -d' ' -f2-)
        if test -n "$ppid"
            set -l pcmd (ps -o comm= -p $ppid 2>/dev/null | string trim)
            echo "  $pid ($cmd)  ←  parent: $ppid ($pcmd)"
        else
            echo "  $pid (gone before we could read it)"
        end
    end

    echo "killing: $pids"
    kill -9 $pids
end
