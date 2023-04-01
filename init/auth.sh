#!/bin/bash
set -euo pipefail

function get_sudo_credentials {
	local password
	local __resultvar=$1
	read -sp "Sudo password: " password
	eval $__resultvar="$password"
	return 0
}
