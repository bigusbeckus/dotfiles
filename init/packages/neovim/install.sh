#!/bin/bash
set -euo pipefail

# Build neovim from source and install
function install_neovim_source() {
	mkdir __temp
	cd __temp
	git clone https://github.com/neovim/neovim.git
	# cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
	cd neovim && make CMAKE_BUILD_TYPE=Release
	# git checkout stable
	echo $password | sudo -S make install
	cd ..
	rm -rf __temp
}

function install_neovim_brew() {
	brew install neovim
}

function install_neovim() {
	local __nviminstalltype=$1

	if [ "${__nviminstalltype,,}" = "brew"]; then
		echo "Installing neovim from homebrew..."
		install_neovim_brew
	elif [ "${__nviminstalltype,,}" = "source" ]; then
		echo "Building neovim from source"
		install_neovim_source
	fi

	# Install packer.nvim (package manager)
	git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
}

# Install
install_neovim brew
