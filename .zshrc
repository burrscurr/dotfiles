# ZSH completions
fpath+=(~/.zsh/completions)
autoload -U compinit
compinit

# Agnoster theme
source $HOME/.zsh/themes/agnoster.zsh

export TERM=xterm-256color

HISTFILE=~/.zsh/history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Use vim keybindings
bindkey -v

# Prefix-based history with arrow keys
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# language settings
LANG=en_US.UTF-8
LC_MESSAGES=en_US.UTF-8

# Use vim as editor.
export VISUAL=vim

alias el="exa -l"
alias ela="exa -al"

alias ga="git add"
alias gs="git status"
alias gc="git commit"
alias gl="git log"
