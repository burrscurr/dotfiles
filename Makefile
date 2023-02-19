DOTFILES=$(shell pwd)
ZSH_COMPLETIONS=~/.zsh/completions
ZSH_THEMES=~/.zsh/themes
VIM_PLUGIN_DIR=~/.vim/pack/plugins/start

install: zsh vim tmux git

zsh: bat exa fd delta
	mkdir -p $(ZSH_COMPLETIONS)
	mkdir -p $(ZSH_THEMES)
	ln -sf $(DOTFILES)/agnoster.zsh $(ZSH_THEMES)/agnoster.zsh
	ln -sf $(DOTFILES)/.zshrc $${HOME}/.zshrc

# Rust syntax highlighting and code formatting.
# https://github.com/rust-lang/rust.vim#installation
rustvim: rust-toolchain
	./clone-or-pull https://github.com/rust-lang/rust.vim $(VIM_PLUGIN_DIR)/rust.vim

# Python code formatter.
# https://black.readthedocs.io/en/stable/integrations/editors.html#vim
# Requires +python3; installs black in virtual environment on first use.
black:
	./clone-or-pull https://github.com/psf/black $(VIM_PLUGIN_DIR)/black

# Static syntax and style checker for python source code.
# flake8 mut be in PATH.
flake8:
	./clone-or-pull https://github.com/nvie/vim-flake8 $(VIM_PLUGIN_DIR)/vim-flake8

# Sort python imports.
# The selected plugin installs isort automatically and calls isort directly
# (requires +python3).
isort:
	./clone-or-pull https://github.com/davidszotten/isort-vim-2 $(VIM_PLUGIN_DIR)/isort-vim-2

# Vim plugins without external dependencies
vim-simple-plugins:
	./clone-or-pull https://github.com/itchyny/lightline.vim $(VIM_PLUGIN_DIR)/lightline
	./clone-or-pull https://github.com/ervandew/supertab.git $(VIM_PLUGIN_DIR)/supertab --depth=1
	./clone-or-pull https://github.com/vim-python/python-syntax $(VIM_PLUGIN_DIR)/python-syntax
	./clone-or-pull https://github.com/moon-musick/vim-logrotate $(VIM_PLUGIN_DIR)/vim-logrotate
	./clone-or-pull https://github.com/uiiaoo/java-syntax.vim $(VIM_PLUGIN_DIR)/java-syntax
	./clone-or-pull https://github.com/projectfluent/fluent.vim $(VIM_PLUGIN_DIR)/fluent.vim
	./clone-or-pull https://github.com/lifepillar/pgsql.vim.git $(VIM_PLUGIN_DIR)/pgsql
	./clone-or-pull https://github.com/burrscurr/vim-pgpass.git $(VIM_PLUGIN_DIR)/vim-pgpass

# Vim plugins with external dependencies.
vim-dep-plugins: rustvim black flake8 isort

vimrc:
	ln -sf $(DOTFILES)/.vimrc $${HOME}/.vimrc

vim: vimrc fzf vim-dep-plugins vim-simple-plugins
	ln -sf $(DOTFILES)/.vimrc $${HOME}/.vimrc

tmux:
	ln -sf $(DOTFILES)/.tmux.conf $${HOME}/.tmux.conf

git:
	ln -sf $(DOTFILES)/.gitconfig $${HOME}/.gitconfig
	ln -sf $(DOTFILES)/.gitignore_global $${HOME}/.gitignore_global

fzf:
	./clone-or-pull https://github.com/junegunn/fzf.git ~/.fzf --depth=1
	~/.fzf/install --no-completion --no-update-rc --key-bindings --bin

rust-toolchain:
	cargo -V || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	cargo -V || . $${HOME}/.cargo/env
	rustup completions zsh rustup > $(ZSH_COMPLETIONS)/_rustup
	rustup completions zsh cargo > $(ZSH_COMPLETIONS)/_cargo

# Various rust command line utilities
bat: rust-toolchain
	cargo install --locked bat
exa: rust-toolchain
	cargo install exa
fd: rust-toolchain
	cargo install fd-find
delta: rust-toolchain
	cargo install git-delta
