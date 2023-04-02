#!/bin/bash

set -euo pipefail

function install_bun() {
	if ! command -v bun &>/dev/null; then
		# Install bun
		echo "Bun command not found, installing..."
		curl -fsSL https://bun.sh/install | bash
		source ~/.bashrc
		echo "Done"
	fi
}

install_bun
