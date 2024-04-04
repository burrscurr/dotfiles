# dotfiles

personal dotfiles and shell setup

## Installation

Run `make` to install the dotfiles and related dependencies.
Dotfiles typically are symlinked to the local copy
of this repository, which makes it easy to compare/exchange upstream and local changes.

On Debian systems, most relevant prequisites can be installed with `apt`:

```
sudo apt install -y build-essential python3-pip zsh git make tmux
```

For neovim, it is advisable to use a more recent version than the packaged one,
have a look [install instructions](https://github.com/neovim/neovim/blob/master/INSTALL.md#pre-built-archives-2)
on Github.

## Caveats

### zsh

On debian-based operating systems, the arrow keys don't apply prefix based
search properly in some cases. See [this
discussion](https://www.zsh.org/mla/users/2014/msg00567.html)
and the comments in `.vimrc` for a solution.
