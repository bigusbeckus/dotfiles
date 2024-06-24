#!/usr/bin/env bash
set -euo pipefail

# Install fedora specific packages
function install_fedora_packages() {
	local __password=$1
	echo "$__password" | sudo -S dnf groupinstall 'Development Tools' -y
	echo "$__password" | sudo -S dnf install \
		gcc-c++ \
		musl-gcc \
		mingw-64-gcc \
		mingw-32-gcc \
		patch \
		pkgconfig \
		procps-ng \
		python3-virtualenv \
		glibc-devel \
		glibc-static \
		-y
	echo "$__password" | sudo -S dnf install \
		freetype-devel \
		fontconfig-devel \
		libxcb-devel \
		libxkbcommon-devel \
		g++ \
		-y

	# Android studio and Haskell deps
	echo "$__password" | sudo -S dnf install \
		ncurses \
		ncurses-compat-libs
	# Haskell deps
	echo "$__password" | sudo -S dnf install \
		gmp \
		gmp-devel \
		-y
}
