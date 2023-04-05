#!/bin/bash
set -euo pipefail

# Install fedora specific packages
function install_fedora_packages() {
	local __password=$1
	echo "$__password" | sudo -S dnf groupinstall 'Development Tools' -y
	echo "$__password" | sudo -S dnf install \
		gcc-c++ \
		patch \
		pkgconfig \
		procps-ng \
		python3-virtualenv \
		glibc-devel \
		-y
}
