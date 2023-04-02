#!/bin/bash
set -euo pipefail

source auth.sh

# Get superuser password
if ! get_sudo_credentials password; then
	echo "Sudo password required. Program will now exit"
	exit 1
fi

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
echo "$password" | eval "$adminupgradecmd -y"

# Install common utils and programs
eval "echo "$password" | $admininstallcmd \
  curl \
  zsh \
  htop \
  python3 \
  python3-sqlparse \
  -y"

# Install build tools
eval "echo "$password" | $admininstallcmd \
  gcc \
  libtool \
  ninja-build \
  gettext \
  autoconf \
  automake \
	make \
  cmake \
  unzip \
  file \
  mercurial \
  bison \
  -y"

# Install homebrew prerequisite packages
if [ "${os,,}" = "ubuntu" ]; then
	source prerequisites/ubuntu.sh
	install_ubuntu_packages $password
elif [ "${os,,}" = "fedora" ]; then
	source prerequisites/fedora.sh
	install_fedora_packages $password
fi

# Unattended install for oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install packages
./packages/install.sh

# Apply configs
cd ../config
./apply.sh -y

# Set zsh as the default shell
chsh -s /usr/bin/zsh

# Uncomment ZSH path export
sed -Ei 's/# (export PATH=.+\:\$PATH)/\1/g' ~/.zshrc

# Set my minibash theme
sed -Ei 's/ZSH_THEME=".+"/ZSH_THEME="minibash"/g' ~/.zshrc
