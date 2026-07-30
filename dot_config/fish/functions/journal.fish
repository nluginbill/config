function journal --description "Open a journal entry in Neovim and sync it to GitHub"
    set -l repo "$HOME/Documents/journal"
    set -l date_str (date +%Y-%m-%d)
    test -n "$argv[1]"; and set date_str $argv[1]

    if not test -d "$repo/.git"
        echo "journal: no git repo at $repo" >&2
        return 1
    end

    # Pick up entries written on another machine before editing.
    git -C $repo pull --quiet --rebase --autostash 2>/dev/null

    set -l file "$repo/entries/$date_str.md"
    mkdir -p (dirname $file)
    if not test -f $file
        set -l heading (date -j -f %Y-%m-%d $date_str "+%A, %B %-d, %Y" 2>/dev/null)
        test -n "$heading"; or set heading $date_str
        printf '# %s\n\n' $heading >$file
    end

    nvim +'normal! G' +startinsert $file

    # Commit and push whatever changed, staying quiet when nothing did.
    git -C $repo add -A
    if git -C $repo diff --cached --quiet
        return 0
    end
    git -C $repo commit --quiet -m "Journal: $date_str"
    if not git -C $repo push --quiet 2>/dev/null
        echo "journal: committed locally, push failed — run 'git -C $repo push' when online"
    end
end
