function vd --description 'Open daily note in nvim'
    # Ensure daily note exists
    obsidian daily 2>/dev/null

    # Build full path and open in nvim
    set -l vault_path (obsidian vault info=path 2>/dev/null)
    set -l daily_path (obsidian daily:path 2>/dev/null)
    v "$vault_path/$daily_path"
end
