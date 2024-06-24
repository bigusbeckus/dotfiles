#!/usr/bin/env bash
set -euo pipefail

# Detect OS (ubuntu, fedora, or arch)
function get_os_name() {
	local __resultvar=$1
	local detectedos

	if [[ -f /etc/os-release ]]; then
		detectedos=$(awk -F= '/^ID=/ {gsub(/"/, "", $2); print $2}' /etc/os-release)
	fi

	if [[ -z "$detectedos" ]]; then
		eval $__resultvar="unknown"
		return 1
	else
		eval $__resultvar="$detectedos"
		return 0
	fi
}

# function get_os_name() {
# 	local __resultvar=$1
# 	local os=$(cat /etc/os-release | grep -w ID | cut -d '=' -f 2)
#
# 	if [ -z "$os" ]; then
# 		eval $__resultvar="unknown"
# 		return 1
# 	else
#     typeset "$__resultvar=$os"
# 		return 0
# 	fi
# }

# Get the install and upgrade commands for the given OS
function get_package_install_commands() {
	local os=$1
	local __installcmd=$2
	local __upgradecmd=$3
	local __admininstallcmd=$4
	local __adminupgradecmd=$5

	if [ "${os,,}" = "ubuntu" ]; then
		echo "Using apt as the package manager"
		eval $__installcmd="'apt install'"
		eval $__upgradecmd="'apt update; apt upgrade'"
		eval $__admininstallcmd="'sudo -S apt install'"
		eval $__adminupgradecmd="'sudo -S apt update; sudo apt upgrade'"
		return 0
	fi

	if [ "${os,,}" = "fedora" ]; then
		echo "Using dnf as the package manager"
		eval $__installcmd="'dnf install'"
		eval $__upgradecmd="'dnf upgrade'"
		eval $__admininstallcmd="'sudo -S dnf install'"
		eval $__adminupgradecmd="'sudo -S dnf upgrade'"
		return 0
	fi

	# if [ "${os,,}" = "arch" ]; then
	# 	echo "Using pacman as the package manager"
	# 	eval $__installcmd="'pacman -S'"
	# 	eval $__upgradecmd="'pacman -Syu'"
	# 	eval $__admininstallcmd="'sudo pacman -S'"
	# 	eval $__adminupgradecmd="'sudo pacman -Syu'"
	# 	return 0
	# fi

	echo "Unsupported OS. Program will now exit."
	return 1
}
