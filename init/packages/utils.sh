#!/bin/bash
set -euo pipefail

function install_packages() {
	local __installpackage=$1
  echo "utils.sh pwd:" "$(pwd)"
	# Read package names from packages.txt
	while read package; do
		# Install package using Homebrew
		$__installpackage "$package" || {
			echo "Failed to install package $package"
			return 1
		}
	done <packages.txt
}
