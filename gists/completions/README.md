## `rabbitmqctl` completions

I have this in my `~/.zshrc`

```zsh
fpath=( "$HOME/.zcompletions" $fpath )
autoload -Uz compinit
compinit
```

I have `rabbitmqctl.zsh` saved as `~/.zcompletions/_rabbitmqctl`
