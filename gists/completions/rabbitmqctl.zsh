#compdef rabbitmqctl

_rabbitmqctl() {
    local matches=($(${words[1]} autocomplete "${(@)words[2,$CURRENT]}"))
    compadd -a matches

    if [[ $compstate[nmatches] -eq 0 && $words[$CURRENT] != -* ]]; then
        _files
    fi
}

if [[ "$(basename -- ${(%):-%x})" != "_rabbitmqctl" ]]; then
    compdef _rabbitmqctl rabbitmqctl
fi
