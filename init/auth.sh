#!/bin/bash
set -euo pipefail

function get_sudo_credentials {
	local __resultvar=$1
	local pass
	read -sp "Sudo password: " pass
	eval $__resultvar="$pass"
	return 0
}
