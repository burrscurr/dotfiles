DOTFILES=$(shell pwd)
ZSH_COMPLETIONS=~/.zsh/completions
ZSH_THEMES=~/.zsh/themes
XDG_CONFIG_DIR=~/.config

install: zsh nvim tmux git psqlrc zsh-cli-tools cli-tools-opt

zsh:
	mkdir -p $(ZSH_THEMES)
	install/ln-safe.sh $(DOTFILES)/agnoster.zsh $(ZSH_THEMES)/agnoster.zsh
	install/ln-safe.sh $(DOTFILES)/.zshrc $${HOME}/.zshrc

nvim-py-formatting:
	pip install ruff
	pip install pynvim
	pip install pyright

nvim: nvim-py-formatting
	mkdir -p $(XDG_CONFIG_DIR)/nvim
	install/ln-safe.sh $(DOTFILES)/init.lua $(XDG_CONFIG_DIR)/nvim/init.lua
	install/package.sh lua5.1 lua

vim:
	install/ln-safe.sh $(DOTFILES)/.vimrc $${HOME}/.vimrc

tmux:
	install/ln-safe.sh $(DOTFILES)/.tmux.conf $${HOME}/.tmux.conf

git: delta
	install/ln-safe.sh $(DOTFILES)/.gitconfig $${HOME}/.gitconfig
	install/ln-safe.sh $(DOTFILES)/.gitignore_global $${HOME}/.gitignore_global

psqlrc:
	install/ln-safe.sh $(DOTFILES)/.psqlrc $${HOME}/.psqlrc

# CLI tools that are used in zsh config
zsh-cli-tools: bat eza fd $(ZSH_COMPLETIONS)/_rustup $(ZSH_COMPLETIONS)/_cargo

cli-tools-opt: tldr rg httpie

rust-toolchain:
	cargo -V > /dev/null || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh;
	cargo -V > /dev/null || . $${HOME}/.cargo/env
$(ZSH_COMPLETIONS)/_rustup: rust-toolchain
	mkdir -p $(ZSH_COMPLETIONS)
	rustup completions zsh rustup > $(ZSH_COMPLETIONS)/_rustup
$(ZSH_COMPLETIONS)/_cargo: rust-toolchain
	mkdir -p $(ZSH_COMPLETIONS)
	rustup completions zsh cargo > $(ZSH_COMPLETIONS)/_cargo

# Various rust command line utilities
bat: rust-toolchain
	bat --version > /dev/null || install/rust-cli-tool.sh bat bat bat
eza: rust-toolchain
	eza --version > /dev/null || cargo install eza
fd: rust-toolchain
	fd --version > /dev/null || install/rust-cli-tool.sh fd-find fd fd-find
delta: rust-toolchain
	delta --version > /dev/null || install/rust-cli-tool.sh git-delta git-delta git-delta

tldr: rust-toolchain
	tldr --version > /dev/null || cargo install tealdeer
	mkdir -p $(XDG_CONFIG_DIR)/tealdeer
	install/ln-safe.sh $(DOTFILES)/tealdeer/config.toml $(XDG_CONFIG_DIR)/tealdeer/config.toml
rg: rust-toolchain
	rg -V > /dev/null || install/rust-cli-tool.sh ripgrep ripgrep ripgrep
httpie:
	pip install httpie
