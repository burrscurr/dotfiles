DOTFILES=$(shell pwd)
ZSH_COMPLETIONS=~/.zsh/completions
ZSH_THEMES=~/.zsh/themes
VIM_PLUGIN_DIR=~/.vim/pack/plugins/start

install: zsh vim tmux git psqlrc

zsh: bat exa fd delta $(ZSH_COMPLETIONS)/_rustup $(ZSH_COMPLETIONS)/_cargo
	mkdir -p $(ZSH_COMPLETIONS)
	mkdir -p $(ZSH_THEMES)
	install/ln-safe.sh $(DOTFILES)/agnoster.zsh $(ZSH_THEMES)/agnoster.zsh
	install/ln-safe.sh $(DOTFILES)/.zshrc $${HOME}/.zshrc

vim-python3:
	vim --version | grep "+python3"

vim-rs-formatting: rust-toolchain
	install/clone-or-pull.sh https://github.com/rust-lang/rust.vim $(VIM_PLUGIN_DIR)/rust.vim

vim-py-formatting: black flake8 isort
black: vim-python3
	install/clone-or-pull.sh https://github.com/psf/black $(VIM_PLUGIN_DIR)/black
flake8:
	install/clone-or-pull.sh https://github.com/nvie/vim-flake8 $(VIM_PLUGIN_DIR)/vim-flake8
	flake8 --version > /dev/null || python3 -m pip install --user flake8
isort: vim-python3
	install/clone-or-pull.sh https://github.com/davidszotten/isort-vim-2 $(VIM_PLUGIN_DIR)/isort-vim-2

vim-general:
	install/clone-or-pull.sh https://github.com/itchyny/lightline.vim $(VIM_PLUGIN_DIR)/lightline
	install/clone-or-pull.sh https://github.com/ervandew/supertab.git $(VIM_PLUGIN_DIR)/supertab --depth=1
	install/clone-or-pull.sh https://github.com/terryma/vim-smooth-scroll $(VIM_PLUGIN_DIR)/vim-smooth-scroll
vim-highlight:
	install/clone-or-pull.sh https://github.com/vim-python/python-syntax $(VIM_PLUGIN_DIR)/python-syntax
	install/clone-or-pull.sh https://github.com/moon-musick/vim-logrotate $(VIM_PLUGIN_DIR)/vim-logrotate
	install/clone-or-pull.sh https://github.com/uiiaoo/java-syntax.vim $(VIM_PLUGIN_DIR)/java-syntax
	install/clone-or-pull.sh https://github.com/projectfluent/fluent.vim $(VIM_PLUGIN_DIR)/fluent.vim
	install/clone-or-pull.sh https://github.com/lifepillar/pgsql.vim.git $(VIM_PLUGIN_DIR)/pgsql
	install/clone-or-pull.sh https://github.com/burrscurr/vim-pgpass.git $(VIM_PLUGIN_DIR)/vim-pgpass

vim: fzf vim-general vim-highlight vim-py-formatting vim-rs-formatting
	install/ln-safe.sh $(DOTFILES)/.vimrc $${HOME}/.vimrc

tmux:
	install/ln-safe.sh $(DOTFILES)/.tmux.conf $${HOME}/.tmux.conf

git:
	install/ln-safe.sh $(DOTFILES)/.gitconfig $${HOME}/.gitconfig
	install/ln-safe.sh $(DOTFILES)/.gitignore_global $${HOME}/.gitignore_global

psqlrc:
	install/ln-safe.sh $(DOTFILES)/.psqlrc $${HOME}/.psqlrc

fzf:
	install/clone-or-pull.sh https://github.com/junegunn/fzf.git ~/.fzf --depth=1
	~/.fzf/install --no-completion --no-update-rc --key-bindings --bin

rust-toolchain:
	cargo -V > /dev/null || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh;
	cargo -V > /dev/null || . $${HOME}/.cargo/env
$(ZSH_COMPLETIONS)/_rustup: rust-toolchain
	rustup completions zsh rustup > $(ZSH_COMPLETIONS)/_rustup
$(ZSH_COMPLETIONS)/_cargo: rust-toolchain
	rustup completions zsh cargo > $(ZSH_COMPLETIONS)/_cargo

# Various rust command line utilities
bat: rust-toolchain
	bat --version > /dev/null || install/rust-cli-tool.sh bat bat bat
exa: rust-toolchain
	exa --version > /dev/null || install/rust-cli-tool.sh exa exa exa
fd: rust-toolchain
	fd --version > /dev/null || install/rust-cli-tool.sh fd-find fd fd-find
delta: rust-toolchain
	delta --version > /dev/null || install/rust-cli-tool.sh git-delta git-delta git-delta
