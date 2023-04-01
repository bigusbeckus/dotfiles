#!/bin/bash
set -euo pipefail

function install_latest_gvm() {
	# Install gvm (Go Version Manager)
	bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

	# Re-source bashrc
	source ~/.bashrc
}

function install_golang() {
	# Install golang (must install the v1.20 binaries first because v1.5+ replaced the C compiler with a Go compiler)
	# https://github.com/moovweb/gvm#a-note-on-compiling-go-15
	gvm install go1.20 -B
	# shellcheck source=/dev/null
	source ~/.gvm/scripts/gvm # Source gvm after install but before use so use works inside the script
	gvm use go1.20
	# Install latest version of golang
	if ! get_go_latest golatest; then
		echo "Go latest version installation failed"
	else
		gvm install "$golatest"
		# shellcheck source=/dev/null
		source ~/.gvm/scripts/gvm
		gvm use "$golatest"
	fi
}

# Install
install_latest_gvm
install_golang
