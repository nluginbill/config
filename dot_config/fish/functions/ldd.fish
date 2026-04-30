function ldd --description 'lazydocker with dev compose files'
    COMPOSE_FILE=compose.yaml:compose.dev.yaml lazydocker $argv
end
