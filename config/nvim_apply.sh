#!/bin/bash

# Define the config directories
nvim_config_dir=~/.config/nvim

echo "Warning: This will overwrite any existing neovim configs in the ~/.config/nvim directory"
read -p "Are you sure you want to continue? (y/N) " -n 1 -rs
echo
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
	# Delete the nvim config directory if it exists
	if [ -d "$nvim_config_dir" ]; then
		rm -r "$nvim_config_dir"
	fi
	# Create the directory and copy the config files
	mkdir -p "$nvim_config_dir"
	cp -r nvim/* "$nvim_config_dir"
	echo "Neovim config files copied."
else
	echo "Aborted"
	exit 1
fi
