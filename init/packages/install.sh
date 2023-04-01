#!/bin/bash
set -euo pipefail

ls -d */ | sed 's/\/$//' | while read module; do
	./"$module"/install.sh
done
