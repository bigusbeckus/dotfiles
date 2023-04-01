#!/bin/bash
set -euo pipefail

function install_packages() {
	local __installpackage=$1
	# Read package names from packages.txt
	while read package; do
		# Install package using Homebrew
		$__installpackage "$package" || {
			echo "Failed to install package $package"
			return 1
		}
	done <packages.txt
}
