#!/bin/bash
set -euo pipefail

source ../utils.sh

function install_volta() {
	curl https://get.volta.sh | bash
	export PATH=$HOME/.volta/bin
}

function install_node() {
	volta install node
}

function install_npm_package() {
	local package=$1

	npm install -g npm@latest

	# Check if package is already installed
	if npm ls -g "$package" >/dev/null 2>&1; then
		echo "Package $package is already installed, skipping..."
		return 0
	fi

	# Install package using npm
	echo "Installing $package..."
	if ! npm install -g $package; then
		echo "Failed to install package $package"
		return 1
	fi

	return 0
}

# Install
install_volta
install_node
install_packages install_npm_package
