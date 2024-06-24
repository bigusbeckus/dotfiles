#!/usr/bin/env bash
set -euo pipefail

source ../utils.sh
source ./node_utils.sh

function install_volta() {
	curl https://get.volta.sh | bash
	export PATH=$HOME/.volta/bin
}

function install_node() {
	volta install node
}

# Install
install_volta
install_node
npm install -g npm@latest
install_packages install_npm_package
