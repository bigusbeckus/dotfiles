#!/bin/bash

set -euo pipefail

function install_bun() {
	if ! command -v bun &>/dev/null; then
		# Install bun
		echo "Bun command not found, installing..."
		curl -fsSL https://bun.sh/install | bash

		# Update zshrc
		echo "" >>~/.zshrc
		echo "# bun completions" >>~/.zshrc
		echo "[ -s \"\$HOME/.bun/_bun\" ] && source \"\$HOME/.bun/_bun\"" >>~/.zshrc

		# bun
		echo "" >>~/.zshrc
		echo "export BUN_INSTALL=\"\$HOME/.bun\"" >>~/.zshrc
		echo "export PATH=\"\$BUN_INSTALL/bin:\$PATH\"" >>~/.zshrc

		echo "Done"
	fi
}

install_bun
