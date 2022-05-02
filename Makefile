DOTFILES=$(shell pwd)

install: zsh vim tmux

zsh:
	ln -s $(DOTFILES)/.zshrc $${HOME}/.zshrc

vim:
	ln -s $(DOTFILES)/.vimrc $${HOME}/.vimrc

tmux:
	ln -s $(DOTFILES)/.tmux.conf $${HOME}/.tmux.conf
