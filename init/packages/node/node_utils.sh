#!/usr/bin/env bash
set -euo pipefail

function install_npm_package() {
	local package=$1

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
