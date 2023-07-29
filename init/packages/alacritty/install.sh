#!/usr/bin/env bash

# Install alacritty from source
# Instructions: https://github.com/alacritty/alacritty/blob/master/INSTALL.md
function install_alacritty_source() {
	# Clone and build
	__tempdir=__alacritty_temp
	mkdir -p $__tempdir
	cd $tempdir

	git clone https://github.com/alacritty/alacritty.git
	cd alacritty

	echo "Building alacritty from source..."
	cargo build --release
	echo "Alacritty binaries built"

	# Ensure alacritty terminfo is installed
	if ! command -v infocmp alacritty &>/dev/null; then
		sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
	fi

	# Add binary to path
	sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH

	# Create alacritty desktop entry
	sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
	sudo desktop-file-install extra/linux/Alacritty.desktop
	sudo update-desktop-database

	# Add man pages
	sudo mkdir -p /usr/local/share/man/man1
	sudo mkdir -p /usr/local/share/man/man5
	scdoc <extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz >/dev/null
	scdoc <extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz >/dev/null
	scdoc <extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz >/dev/null
	scdoc <extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz >/dev/null

	# Add alacritty shell completion
	# zsh
	mkdir -p ${ZDOTDIR:-~}/.zsh_functions
	echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >>${ZDOTDIR:-~}/.zshrc
	cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty
	# bash
	mkdir -p ~/.bash_completion
	cp extra/completions/alacritty.bash ~/.bash_completion/alacritty
	echo "source ~/.bash_completion/alacritty" >>~/.bashrc
}

function install_alacritty() {
	if ! command -v alacritty &>/dev/null; then
		install_alacritty_source
	else
		echo "Alacritty already installed"
	fi
}

install_alacritty
