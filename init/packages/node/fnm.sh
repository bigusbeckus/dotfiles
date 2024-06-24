#!/usr/bin/env bash
set -euo pipefail

source ../utils.sh
source ./node_utils.sh

function install_fnm() {
	# Install fnm
	curl -fsSL https://fnm.vercel.app/install | bash

	# Add fnm zsh configs
	echo "# fnm" >>~/.zshrc
	echo "export PATH=\"/home/beck/.local/share/fnm:\$PATH\"" >>~/.zshrc
	echo "eval \"\`fnm env\`\"" >>~/.zshrc
}

function install_node() {
	fnm install --lts
}

# Install
install_fnm
install_node
npm install -g npm@latest
install_packages install_npm_package
