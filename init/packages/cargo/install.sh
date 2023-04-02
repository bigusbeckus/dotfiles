#!/bin/bash
set -euo pipefail

source ../utils.sh

function install_cargo() {
	# Check if cargo is installed
	if ! command -v cargo >/dev/null 2>&1; then
		# Install cargo and rust
		echo "Cargo command not found, installing..."
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
		echo "Done"
		source ~/.cargo/env
	fi
}

function install_cargo_package() {
	local package=$1

	# Check if package is already installed
	if cargo install --list | grep -q "^$package\$"; then
		echo "Package $package is already installed, skipping..."
		return 0
	fi

	# Install package using Cargo
	echo "Installing $package..."
	if ! cargo install $package; then
		echo "Failed to install package $package"
		return 1
	fi

	return 0
}

# Install
install_cargo
install_packages install_cargo_package
