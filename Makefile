DOTFILES=$(shell pwd)

install: zsh vim tmux git

zsh:
	ln -s $(DOTFILES)/.zshrc $${HOME}/.zshrc

# Rust syntax highlighting and code formatting.
# https://github.com/rust-lang/rust.vim#installation
rustvim: rust-toolchain
	git clone https://github.com/rust-lang/rust.vim ~/.vim/pack/plugins/start/rust.vim

# Python code formatter.
# https://black.readthedocs.io/en/stable/integrations/editors.html#vim
# Requires +python3; installs black in virtual environment on first use.
black:
	git clone --branch stable https://github.com/psf/black ~/.vim/pack/plugins/start/black

vim: exa rustvim black
	ln -s $(DOTFILES)/.vimrc $${HOME}/.vimrc

tmux:
	ln -s $(DOTFILES)/.tmux.conf $${HOME}/.tmux.conf

git:
	ln -s $(DOTFILES)/.gitconfig $${HOME}/.gitconfig
	ln -s $(DOTFILES)/.gitignore_global $${HOME}/.gitignore_global

rust-toolchain:
	cargo -V || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	cargo -V || . $${HOME}/.cargo/env

exa: rust-toolchain
	exa --version || cargo install exa
