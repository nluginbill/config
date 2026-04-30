function ldp --description 'lazydocker with prod compose files'
    COMPOSE_FILE=compose.yaml:compose.prod.yaml lazydocker $argv
end
