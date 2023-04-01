#!/bin/bash
set -euo pipefail

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
