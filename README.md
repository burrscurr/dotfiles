# dotfiles

personal dotfiles and shell setup

## Installation

Run `make` to install the dotfiles and related dependencies.
Dotfiles typically are symlinked to the local copy
of this repository, which makes it easy to compare/exchange upstream and local changes.

## Caveats

### zsh

On debian-based operating systems, the arrow keys don't apply prefix based
search properly in some cases. See [this
discussion](https://www.zsh.org/mla/users/2014/msg00567.html)
and the comments in `.vimrc` for a solution.

### vim

Requires version 8+ (built-in packages) with `+python3` (check `vim --version` output).
