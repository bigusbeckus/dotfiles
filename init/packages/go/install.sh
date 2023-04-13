#!/bin/bash

function get_go_latest() {
	# Version listing logic "borrowed" from gvm source
	local __resultvar=$1

	local gostableversionregex='^go[1-9][0-9]*(\.[0-9]*)*$'
	local goversionslist=$(git ls-remote -t https://github.com/golang/go | awk -F/ '{ print $NF }')
	if [[ $? -ne 0 ]]; then
		eval $__resultvar="unknown"
		return 1
	fi

	local golatestversion=$(for version in $goversionslist; do
		if [[ $version =~ $gostableversionregex ]]; then
			echo $version
		fi
	done | sort -V | tail -n1)

	if [[ -z $golatestversion ]]; then
		eval $__resultvar="unknown"
		return 1
	else
		eval $__resultvar="$golatestversion"
		return 0
	fi
}

function install_latest_gvm() {
	if ! command -v gvm &>/dev/null; then
		# Install gvm (Go Version Manager)
		bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

		# Add gvm to .zshrc
		echo [[ -s \"$HOME/.gvm/scripts/gvm\" ]] \&\& "source" \"$HOME/.gvm/scripts/gvm\" >>~/.zshrc

		source ~/.gvm/scripts/gvm # Source gvm
	else
		echo "Go version manager already installed"
	fi
}

function install_golang() {
	if ! command -v go &>/dev/null; then
		# Install golang (must install the v1.20 binaries first because v1.5+ replaced the C compiler with a Go compiler)
		# https://github.com/moovweb/gvm#a-note-on-compiling-go-15
		gvm install go1.20 -B
		# shellcheck source=/dev/null
		source ~/.gvm/scripts/gvm # Source gvm after install but before use so use works inside the script
		gvm use go1.20
		# Install latest version of golang
		if ! get_go_latest golatest; then
			echo "Go latest version installation failed"
			return 1
		else
			gvm install "$golatest"
			source ~/.gvm/scripts/gvm
			gvm use "$golatest" --default
			return 0
		fi
	else
		echo "Go already installed"
	fi
}

# Install
install_latest_gvm
install_golang
