# ZSH completions
fpath+=~/.zfunc

source $HOME/.antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle command-not-found

# Syntax highlighting bundle.
# antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions

# Load the theme.
antigen theme agnoster 

# Tell Antigen that you're done.
antigen apply

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
