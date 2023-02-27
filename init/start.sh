#!/bin/bash

source distro.sh

# Get operating system
if ! get_os_name os; then
	echo "Unknown OS. Program will now exit"
	exit 1
fi

echo Operating system ID: $os

# Get install commands
if ! get_package_install_commands $os installcmd upgradecmd admininstallcmd adminupgradecmd; then
	echo "Unsupported OS. Program will now exit"
	exit 1
fi

echo "  Install command: " $installcmd
echo "  Upgrade command: " $upgradecmd
echo "  Install command (Admin): " $admininstallcmd
echo "  Upgrade command (Admin): " $adminupgradecmd

# Run upgrade command
echo "Upgrading packages"
eval "$adminupgradecmd -y"

# Install common utils and programs
eval "$admininstallcmd \
  curl \
  zsh \
  htop \
  python3 \
  -y"

# Install build tools
eval "$admininstallcmd \
  libtool \
  ninja-build \
  gettext \
  autoconf \
  automake \
  cmake \
  unzip \
  file \
  -y"

# Install homebrew prerequisite packages
if [ "${os,,}" = "ubuntu" ]; then
	./prerequisites/ubuntu.sh
elif [ "${os,,}" = "fedora" ]; then
	./prerequisites/fedora.sh
fi

# Unattended install for oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Set zsh as the default shell
chsh -s /bin/zsh

./install_packages.sh
../config/apply.sh -y
