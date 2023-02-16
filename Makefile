DOTFILES=$(shell pwd)
ZSH_COMPLETIONS=~/.zsh/completions
ZSH_THEMES=~/.zsh/themes
VIM_PLUGIN_DIR=~/.vim/pack/plugins/start

install: zsh vim tmux git

zsh:
	mkdir -p $(ZSH_COMPLETIONS)
	mkdir -p $(ZSH_THEMES)
	ln -s $(DOTFILES)/agnoster.zsh $(ZSH_THEMES)/agnoster.zsh
	ln -s $(DOTFILES)/.zshrc $${HOME}/.zshrc

# Rust syntax highlighting and code formatting.
# https://github.com/rust-lang/rust.vim#installation
rustvim: rust-toolchain
	git clone https://github.com/rust-lang/rust.vim $(VIM_PLUGIN_DIR)/rust.vim

# Python code formatter.
# https://black.readthedocs.io/en/stable/integrations/editors.html#vim
# Requires +python3; installs black in virtual environment on first use.
black:
	git clone --branch stable https://github.com/psf/black $(VIM_PLUGIN_DIR)/black

# Static syntax and style checker for python source code.
# flake8 mut be in PATH.
flake8:
	git clone https://github.com/nvie/vim-flake8 $(VIM_PLUGIN_DIR)/vim-flake8

# Sort python imports.
# The selected plugin installs isort automatically and calls isort directly
# (requires +python3).
isort:
	git clone https://github.com/davidszotten/isort-vim-2 $(VIM_PLUGIN_DIR)/isort-vim-2

# Vim plugins without external dependencies
vim-simple-plugins:
	git clone https://github.com/itchyny/lightline.vim $(VIM_PLUGIN_DIR)/lightline
	git clone --depth=1 https://github.com/ervandew/supertab.git $(VIM_PLUGIN_DIR)/supertab
	git clone https://github.com/vim-python/python-syntax $(VIM_PLUGIN_DIR)/python-syntax
	git clone https://github.com/moon-musick/vim-logrotate $(VIM_PLUGIN_DIR)/vim-logrotate
	git clone https://github.com/uiiaoo/java-syntax.vim $(VIM_PLUGIN_DIR)/java-syntax
	git clone https://github.com/projectfluent/fluent.vim $(VIM_PLUGIN_DIR)/fluent.vim
	git clone https://github.com/lifepillar/pgsql.vim.git $(VIM_PLUGIN_DIR)/pgsql
	git clone https://github.com/burrscurr/vim-pgpass.git $(VIM_PLUGIN_DIR)/vim-pgpass

# Vim plugins with external dependencies.
vim-dep-plugins: rustvim py-syntax black flake8 isort

vimrc:
	ln -s $(DOTFILES)/.vimrc $${HOME}/.vimrc

vim: vimrc vim-dep-plugins vim-simple-plugins
	ln -s $(DOTFILES)/.vimrc $${HOME}/.vimrc

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
