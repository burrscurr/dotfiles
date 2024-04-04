# dotfiles

personal dotfiles and shell setup

## Prerequisites

On Debian systems, most relevant prequisites can be installed with `apt`:

```
sudo apt install -y build-essential python3-pip zsh git make tmux
```

For neovim, it is advisable to use a more recent version than the packaged one,
have a look [install instructions](https://github.com/neovim/neovim/blob/master/INSTALL.md#pre-built-archives-2)
on Github.

## Installation

```
git clone https://github.com/burrscurr/dotfiles ~/.dotfiles
cd ~/.dotfiles
make
```

The dotfiles typically are symlinked to their local copy
in this repository (that is, in `~/.dotfiles`). Effectively, all dotfiles still
live in the local repo copy, which makes it easy to
compare/exchange upstream to/with local changes using git. If a local version of
a dotfile already exists, say a `~/.zshrc`, it is moved to `~/.zshrc.evacuated`
to avoid being overwritten by the symlink to `~/.dotfiles/.zshrc`.

## Caveats

### zsh

On debian-based operating systems, the arrow keys don't apply prefix based
search properly in some cases. See [this
discussion](https://www.zsh.org/mla/users/2014/msg00567.html)
and the comments in `.vimrc` for a solution.
