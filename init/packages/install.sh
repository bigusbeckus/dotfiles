#!/bin/bash
set -euo pipefail

echo Installing packages...
ls -d */ | sed 's/\/$//' | while read module; do
	echo Installing "$module"
	cd "$module" && ./install.sh && cd ..
done
