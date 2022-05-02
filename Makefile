DOTFILES=$(shell pwd)

install: zsh vim tmux git

zsh:
	ln -s $(DOTFILES)/.zshrc $${HOME}/.zshrc

vim:
	ln -s $(DOTFILES)/.vimrc $${HOME}/.vimrc

tmux:
	ln -s $(DOTFILES)/.tmux.conf $${HOME}/.tmux.conf

git:
	ln -s $(DOTFILES)/.gitconfig $${HOME}/.gitconfig
	ln -s $(DOTFILES)/.gitignore_global $${HOME}/.gitignore_global
