#!/bin/sh

# Define the config directories
nvim_config_dir=~/.config/nvim
zsh_config_dir=~/.oh-my-zsh
git_config_filename=.gitconfig
tmux_config_filename=.tmux.conf
git_config_file=~/$git_config_filename
tmux_config_file=~/$tmux_config_filename
alacritty_config_dir=~/.config/alacritty
zsh_profile_file=~/.zprofile

# Copy over .gitconfig if it exists
if [ -f "$git_config_file" ]; then
	# Create the git directory if it doesn't already exist
	mkdir -p git
	# Copy the config file
	cp "$git_config_file" git/"$git_config_filename"
	echo "Git global config copied."
fi

# Copy over .tmux.conf if it exists
if [ -f "$tmux_config_file" ]; then
	# Create the tmux directory if it doesn't already exist
	mkdir -p tmux
	# Copy the config file
	cp "$tmux_config_file" tmux/"$tmux_config_filename"
	echo "Tmux config file copied."
fi

# Check if the config directories exist
if [ -d "$nvim_config_dir" ]; then
	# Create the nvim directory if it doesn't already exist
	mkdir -p nvim
	# Copy the config files
	cp -r "$nvim_config_dir"/* nvim
	echo "Neovim config files copied."
else
	echo "Neovim config directory not found."
fi

if [ -d "$zsh_config_dir" ]; then
	# Create the zsh/oh-my-zsh directory if it doesn't already exist
	mkdir -p zsh/.oh-my-zsh/custom
	# Copy the config files
	cp -r "$zsh_config_dir"/custom/* zsh/.oh-my-zsh/custom
	echo "Oh-My-Zsh config files copied."
else
	echo "Oh-My-Zsh config directory not found."
fi

if [ -d "$alacritty_config_dir" ]; then
	# Create the alacritty config directory if it doesn't already exist
	mkdir -p alacritty
	# Copy the config files
	cp -r "$alacritty_config_dir"/* alacritty
	echo "Alacritty config files copied."
else
	echo "Alacritty config directory not found."
fi

# Copy over .zprofile if it exists
if [ -f "$zsh_profile_file" ]; then
	mkdir -p zsh
	# Copy the config file
	cp "$zsh_profile_file" zsh/.zprofile
	echo "Git global config copied."
fi

dconf dump /com/gexperts/Tilix/ >tilix/tilix.dconf && echo "Tilix config files copied"
