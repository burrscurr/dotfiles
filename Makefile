DOTFILES=$(shell pwd)
ZSH_COMPLETIONS=~/.zsh/completions
ZSH_THEMES=~/.zsh/themes
NVIM_CONFIG_DIR=~/.config/nvim

install: zsh nvim tmux git psqlrc

zsh: bat exa fd $(ZSH_COMPLETIONS)/_rustup $(ZSH_COMPLETIONS)/_cargo
	mkdir -p $(ZSH_THEMES)
	install/ln-safe.sh $(DOTFILES)/agnoster.zsh $(ZSH_THEMES)/agnoster.zsh
	install/ln-safe.sh $(DOTFILES)/.zshrc $${HOME}/.zshrc

nvim-py-formatting:
	pip install ruff-lsp

nvim: nvim-py-formatting
	mkdir -p $(NVIM_CONFIG_DIR)
	install/ln-safe.sh $(DOTFILES)/init.lua $(NVIM_CONFIG_DIR)/init.lua

vim:
	install/ln-safe.sh $(DOTFILES)/.vimrc $${HOME}/.vimrc

tmux:
	install/ln-safe.sh $(DOTFILES)/.tmux.conf $${HOME}/.tmux.conf

git: delta
	install/ln-safe.sh $(DOTFILES)/.gitconfig $${HOME}/.gitconfig
	install/ln-safe.sh $(DOTFILES)/.gitignore_global $${HOME}/.gitignore_global

psqlrc:
	install/ln-safe.sh $(DOTFILES)/.psqlrc $${HOME}/.psqlrc

clitools-opt: tldr rg httpie

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
exa: rust-toolchain
	exa --version > /dev/null || cargo install exa
fd: rust-toolchain
	fd --version > /dev/null || install/rust-cli-tool.sh fd-find fd fd-find
delta: rust-toolchain
	delta --version > /dev/null || install/rust-cli-tool.sh git-delta git-delta git-delta

tldr: rust-toolchain
	tldr --version > /dev/null || cargo install tealdeer
rg: rust-toolchain
	rg -V > /dev/null || install/rust-cli-tool.sh ripgrep ripgrep ripgrep
httpie:
	pip install httpie
