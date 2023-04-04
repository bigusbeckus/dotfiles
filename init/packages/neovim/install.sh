#!/bin/bash
set -euo pipefail

# Build neovim from source and install
function install_neovim_source() {
	mkdir -p __temp
	cd __temp
	git clone https://github.com/neovim/neovim.git
	# git checkout stable # Uncomment this line to build the stable release
	cd neovim
	make CMAKE_BUILD_TYPE=Release
	# make CMAKE_BUILD_TYPE=RelWithDebInfo # Replace the above line with this one to get stack traces on crash
	echo $SUDO_PASSWORD | sudo -S make install
	cd ../..
	rm -rf __temp
}

function install_neovim_brew() {
	brew install neovim
}

function install_neovim() {
	local __nviminstalltype=$1

	if [ "${__nviminstalltype,,}" = "brew" ]; then
		echo "Installing neovim from homebrew..."
		# Run homebrew install script if it hasn't been run yet
		if ! command -v brew &>/dev/null; then
			echo "Homebrew not found. Installing homebrew before neovim..."
			cd ../linuxbrew
			./install.sh
			cd ../neovim
		fi
		install_neovim_brew
	elif [ "${__nviminstalltype,,}" = "source" ]; then
		echo "Building neovim from source"
		install_neovim_source
	fi

	# Install packer.nvim (package manager)
	git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
}

# Install
install_neovim "source"
