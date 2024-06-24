#!/usr/bin/env bash
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
	echo "$__password" | sudo -S apt install \
		libfreetype6-dev \
		libfontconfig1-dev \
		libxcb-xfixes0-dev \
		libxkbcommon-dev \
		-y
}
