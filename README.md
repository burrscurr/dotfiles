# dotfiles

personal dotfiles and shell setup

## Installation

Run `make` to install all dotfiles. It is recommended to inspect the `Makefile`
and apply targets selectively.

Dotfiles typically are symlinked to this repository, which makes it easy to
compare/exchange upstream and local changes.

### zsh

On debian-based operating systems, the arrow keys don't apply prefix based
search properly in some cases. See [this
discussion](https://www.zsh.org/mla/users/2014/msg00567.html)
for a solution.

The shell setup expects multiple tools which might need to be installed
manually:

```
# Ubuntu
sudo apt install exa bat fzf fd-find
cargo install git-delta

# macos
brew install exa bat git-delta fzf fd
```

### vim

Requires version 8+ (built-in packages) with `+python3` (check `vim --version` output).
