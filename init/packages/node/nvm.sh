#!/bin/bash
set -euo pipefail

source ../utils.sh

function get_nvm_latest() {
	local ghreleaseurl="https://api.github.com/repos/nvm-sh/nvm/releases/latest"
	local fetchedversion=$(curl $ghreleaseurl | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'])")
	local __resultvar=$1
	if [[ -z $fetchedversion ]]; then
		eval $__resultvar="unknown"
		return 1
	else
		eval $__resultvar="$fetchedversion"
		return 0
	fi
}

function install_nvm() {
	# Install node version manager (nvm)
	if ! get_nvm_latest nvmlatest; then
		echo "NVM installation failed"
		return 1
	fi
	# Install nvm
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$nvmlatest/install.sh | bash
	# Add nvm to path
	# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
	# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

	echo "Automatically adding nvm to path..."
	# zsh
	echo "" >>~/.zshrc
	echo "# Add nvm to PATH" >>~/.zshrc
	echo "export NVM_DIR=\"\$HOME/.nvm\"" >>~/.zshrc
	echo "[ -s \"\$NVM_DIR/nvm.sh\" ] && \\. \"\$NVM_DIR/nvm.sh\"                   # This loads nvm" >>~/.zshrc
	echo "[ -s \"\$NVM_DIR/bash_completion\" ] && \\. \"\$NVM_DIR/bash_completion\" # This loads nvm bash_completion" >>~/.zshrc
	# bash
	echo "" >>~/.bashrc
	echo "# Add nvm to PATH" >>~/.bashrc
	echo "export NVM_DIR=\"\$HOME/.nvm\"" >>~/.bashrc
	echo "[ -s \"\$NVM_DIR/nvm.sh\" ] && \\. \"\$NVM_DIR/nvm.sh\"                   # This loads nvm" >>~/.bashrc
	echo "[ -s \"\$NVM_DIR/bash_completion\" ] && \\. \"\$NVM_DIR/bash_completion\" # This loads nvm bash_completion" >>~/.bashrc
	echo "Done"
	# Current shell
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
}

function install_node() {
	nvm install --lts
}

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

# Install
install_nvm
install_node
npm install -g npm@latest
install_packages install_npm_package
