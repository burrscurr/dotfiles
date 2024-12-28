# ZSH completions
fpath+=(~/.zsh/completions)
autoload -U compinit
compinit
# Try to complete matches by prefix, then case-insensitive matches, then substring match.
zstyle ':completion:*' matcher-list 'r:|=*' 'm:{a-zA-Z}={A-Za-z}' 'l:|=* r:|=*'

# Why does this even exist?
unsetopt BEEP

# Agnoster theme
source $HOME/.zsh/themes/agnoster.zsh

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
LC_ALL=en_US.UTF-8

# Use nvim as editor.
export VISUAL=nvim

# fzf settings
export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git'
# Use Ctrl+T runs FZF, Ctrl+R for history search
source "$HOME/.fzf/shell/key-bindings.zsh"
export FZF_CTRL_R_OPTS='--no-sort --exact'
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"
export PATH="$HOME/.fzf/bin:$PATH"

alias v="$VISUAL"  # open editor (similar to 'v' when using less)
alias ls="eza"  # use eza instead of ls for better output (colors) and git integration
alias ll="eza -l"
alias la="eza -al"
alias tree="eza -l --tree --git-ignore"

alias cat="bat --theme=base16"  # use bat instead of cat for better output (highlighting, color, ...)

# On Ubuntu, some CLI tools have different names to avoid name conflicts with existing utilities.
# Uncomment those lines if the package versions are used.
# alias fd="fdfind"
# alias bat="batcat"

alias ga="git add"  # various convenience shortcuts for common git commands
alias gs="git status"
alias gc="git commit"
alias gca="git commit --amend"
alias gl="git log"
alias gr="git rebase"

alias -g ...="../.."
alias -g ....="../../.."

# Cargo installs command line tools into ~/.cargo/bin
# Pip installs to ~/.local/bin
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
