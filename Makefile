DOTFILES=$(shell pwd)

install: vim

vim:
	ln -s $(DOTFILES)/.vimrc $${HOME}/.vimrc
