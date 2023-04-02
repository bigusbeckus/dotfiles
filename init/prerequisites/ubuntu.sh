#!/bin/bash
set -euo pipefail

# Install ubuntu-specific packages
function install_ubuntu_packages() {
	local $__password=$1
	echo "$__password" | sudo -S apt install \
		build-essential \
		doxygen \
		g++ \
		libtool-bin \
		pkg-config \
		procps \
		python3-venv \
		binutils \
		-y
}
