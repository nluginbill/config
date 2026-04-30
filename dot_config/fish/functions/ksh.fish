function ksh --wraps='ssh' --description 'SSH preferring zsh on remote'
    ssh -t $argv 'if command -v zsh >/dev/null 2>&1; then exec zsh; else exec bash; fi'
end
