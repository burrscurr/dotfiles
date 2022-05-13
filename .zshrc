# ZSH completions
fpath+=~/.zfunc

# Agnoster theme
source $HOME/.zsh/themes/agnoster.zsh

# language settings
LANG=en_US.UTF-8
LC_MESSAGES=en_US.UTF-8

# Use vim as editor.
export VISUAL=vim

alias el="exa -l"
alias ela="exa -al"

# Often gs is aliased to "ghostscript"
alias gs="git status"
# default: git commit -v
alias gc="git commit"
# default: git pull
alias gl="git log"
