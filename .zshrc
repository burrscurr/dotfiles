# ZSH completions
fpath+=(~/.zsh/completions)
autoload -U compinit
compinit
# Try to complete matches by prefix, then case-insensitive matches, then substring match.
zstyle ':completion:*' matcher-list 'r:|=*' 'm:{a-zA-Z}={A-Za-z}' 'l:|=* r:|=*'

# Why does this shit even exist?
unsetopt BEEP

# Agnoster theme
source $HOME/.zsh/themes/agnoster.zsh

export TERM=xterm-256color

HISTFILE=~/.zsh/history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Use vim keybindings
bindkey -v

# Prefix-based history with arrow keys.
# On debian, try ${key[Up]} and ${key[Down]} instead (see https://www.zsh.org/mla/users/2014/msg00567.html).
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# language settings
LANG=en_US.UTF-8
LC_MESSAGES=en_US.UTF-8

# Use vim as editor.
export VISUAL=vim

# fzf settings
export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git'
# Use Ctrl+T runs FZF, Ctrl+R for history search
source "$HOME/.fzf/shell/key-bindings.zsh"
export FZF_CTRL_R_OPTS='--no-sort --exact'
export PATH="$HOME/.fzf/bin:$PATH"

alias ls="exa"
alias ll="exa -l"
alias la="exa -al"
alias tree="exa -l --tree --git-ignore"

alias cat="bat --theme=base16"

# On Ubuntu, fd installs as binary fdfind to avoid conflicts with an existing utility named fd.
# For consistency, this is aliased nonetheless to fd.
alias fd="fdfind"

alias ga="git add"
alias gs="git status"
alias gc="git commit"
alias gca="git commit --amend"
alias gl="git log"
alias gr="git rebase"

alias -g ...="../.."
alias -g ....="../../.."
