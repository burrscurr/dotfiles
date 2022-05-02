# dotfiles

## Installation

Run `make` to install all dotfiles. There are several targets available for more
selective installation.

The installed files are symlinked to their respective version in this
repository. This setup makes it easy to compare and exchange upstream and local
changes.

### zsh

[Antigen][antigen] is used as a zsh plugin manager.

### vim

[vim-plug][vim-plug] is used to manage vim plugins. After installation, run
`:PlugInstall` to install the configured vim plugins.

[antigen]: https://github.com/zsh-users/antigen
[vim-plug]: https://github.com/junegunn/vim-plug
