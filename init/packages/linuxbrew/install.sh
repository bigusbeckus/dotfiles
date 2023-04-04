#!/bin/bash
set -euo pipefail

source ../utils.sh

function install_linuxbrew() {
	if ! command -v brew &>/dev/null; then
		# Refresh sudo timestamp because that was causing issues
		echo $SUDO_PASSWORD | sudo -S -v

		# Install homebrew
		NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

		# Set up Homebrew for Bash
		if [[ -r ~/.bash_profile ]]; then
			echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.bash_profile
		fi
		# if [[ -r ~/.bashrc ]]; then
		# 	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.bashrc
		# fi

		# Set up Homebrew for Zsh
		# if [[ -r ~/.zshrc ]]; then
		# 	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.zshrc
		# fi
		if [[ -r ~/.zprofile ]]; then
			echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.zprofile
		fi

		# Add homebrew to path for use within the script
		eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	else
		echo "Brew already installed"
	fi
}

function install_brew_package() {
	local package=$1

	# Check if package is already installed
	if brew list --formula | grep -q "^$package\$"; then
		echo "Package $package is already installed, skipping..."
		return 0
	fi

	# Install package using Homebrew
	echo "Installing $package..."
	if ! brew install $package; then
		echo "Failed to install package $package"
		return 1
	fi

	return 0
}

# Install
install_linuxbrew
install_packages install_brew_package
