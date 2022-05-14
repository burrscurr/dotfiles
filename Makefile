DOTFILES=$(shell pwd)
ZSH_COMPLETIONS=~/.zsh/completions
ZSH_THEMES=~/.zsh/themes
VIM_PLUGIN_DIR=~/.vim/pack/plugins/start

install: zsh vim tmux git exa

zsh:
	mkdir -p $(ZSH_COMPLETIONS)
	mkdir -p $(ZSH_THEMES)
	ln -s $(DOTFILES)/agnoster.zsh $(ZSH_THEMES)/agnoster.zsh
	ln -s $(DOTFILES)/.zshrc $${HOME}/.zshrc

# Nice vim status bar
lightline:
	git clone https://github.com/itchyny/lightline.vim $(VIM_PLUGIN_DIR)/lightline

# Tab completions
supertab:
	git clone --depth=1 https://github.com/ervandew/supertab.git $(VIM_PLUGIN_DIR)/supertab

# Rust syntax highlighting and code formatting.
# https://github.com/rust-lang/rust.vim#installation
rustvim: rust-toolchain
	git clone https://github.com/rust-lang/rust.vim $(VIM_PLUGIN_DIR)/rust.vim

# Python syntax highlighting (including f-strings)
py-syntax:
	git clone https://github.com/vim-python/python-syntax $(VIM_PLUGIN_DIR)/python-syntax

# Python code formatter.
# https://black.readthedocs.io/en/stable/integrations/editors.html#vim
# Requires +python3; installs black in virtual environment on first use.
black:
	git clone --branch stable https://github.com/psf/black $(VIM_PLUGIN_DIR)/black

# Sort python imports.
# The selected plugin installs isort automatically and calls isort directly
# (requires +python3).
isort:
	git clone https://github.com/davidszotten/isort-vim-2 $(VIM_PLUGIN_DIR)/isort-vim-2

pgsql:
	git clone https://github.com/lifepillar/pgsql.vim.git $(VIM_PLUGIN_DIR)/pgsql

vim: vim-plugins
	ln -s $(DOTFILES)/.vimrc $${HOME}/.vimrc

vim-plugins: rustvim py-syntax black isort lightline supertab pgsql

tmux:
	ln -s $(DOTFILES)/.tmux.conf $${HOME}/.tmux.conf

git:
	ln -s $(DOTFILES)/.gitconfig $${HOME}/.gitconfig
	ln -s $(DOTFILES)/.gitignore_global $${HOME}/.gitignore_global

rust-toolchain:
	cargo -V || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	cargo -V || . $${HOME}/.cargo/env
	rustup completions zsh rustup > $(ZSH_COMPLETIONS)/_rustup
	rustup completions zsh cargo > $(ZSH_COMPLETIONS)/_cargo

exa: rust-toolchain
	exa --version || cargo install exa
