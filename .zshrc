# ZSH completions
fpath=($HOME/.zsh/completions $fpath)

# Agnoster theme
source $HOME/.zsh/themes/agnoster.zsh

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
