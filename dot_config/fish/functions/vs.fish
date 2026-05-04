function vs --description 'Open daily scratch in nvim'
    set -l vault_path (obsidian vault info=path 2>/dev/null)
    set -l date_str (date +%Y-%m-%d)
    set -l scratch_path "scratch/$date_str"_scratch.md

    # Ensure daily scratch exists
    obsidian create path="$scratch_path" 2>/dev/null

    v "$vault_path/$scratch_path"
end
