#!/bin/sh

function get_nvm_latest() {
  local ghreleaseurl="https://api.github.com/repos/nvm-sh/nvm/releases/latest"
  local fetchedversion=$(curl $ghreleaseurl | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'])")
  local __resultvar=$1
  if [[ -z $fetchedversion ]]; then
    eval $__resultvar="unknown"
    return 1
  else
		eval $__resultvar="$fetchedversion"
    return 0
  fi
}
