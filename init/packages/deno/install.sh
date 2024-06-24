#!/usr/bin/env bash
set -euo pipefail

function install_deno() {
	if ! command -v deno &>/dev/null; then
		# Install deno and add it to PATH
		curl -fsSL https://deno.land/x/install/install.sh | sh
		# zsh
		echo "" >>~/.zshrc
		echo "# Deno" >>~/.zshrc
		echo "export DENO_INSTALL=$HOME/.deno" >>~/.zshrc
		sed -Ei 's/(export PATH=.+)\:\$PATH/\1\:\$HOME\/\.deno\/bin\:\$PATH/g' ~/.zshrc
		# bash
		echo "" >>~/.bashrc
		echo "# Deno" >>~/.bashrc
		echo "export DENO_INSTALL=$HOME/.deno" >>~/.bashrc
		echo "export PATH=\$HOME/.deno/bin:\$PATH" >>~/.bashrc
	else
		echo "Deno already installed"
	fi
}

# Install
install_deno
