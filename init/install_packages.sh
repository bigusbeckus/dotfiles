#!/bin/bash

source utils.sh

# Install cargo and rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \| sh -s -- -y

# Install homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add homebrew to path
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.bash_profile
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.profile

# Install node version manager (nvm)
if ! get_nvm_latest nvmlatest; then
	echo "NVM installation failed"
else
	# Install nvm
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$nvmlatest/install.sh | bash
	# Add nvm to path
	export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
fi

# Install deno
curl -fsSL https://deno.land/x/install/install.sh | sh

# ===========================================

# Install treesitter
cargo install tree-sitter tree-sitter-cli

# Install fd, ripgrep, and fzf from homebrew
brew install fd ripgrep fzf -y

# Install node, yarn, and pnpm
nvm install --lts
npm install -g npm@latest
npm install -g pnpm
npm install -g yarn
