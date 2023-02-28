#!/bin/bash

source utils.sh

# Install cargo and rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add homebrew to path
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.bash_profile
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.profile
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.bash_profile
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.zsh_profile

# Install node version manager (nvm)
if ! get_nvm_latest nvmlatest; then
	echo "NVM installation failed"
else
	# Install nvm
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$nvmlatest/install.sh | bash
	# Add nvm to path
	# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
	# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

	echo "Automatically adding nvm to path"
	# zsh
	echo "# Add nvm to PATH" >>~/.zshrc
	echo "export NVM_DIR=\"\$HOME/.nvm\"" >>~/.zshrc
	echo "[ -s \"\$NVM_DIR/nvm.sh\" ] && \\. \"\$NVM_DIR/nvm.sh\"                   # This loads nvm" >>~/.zshrc
	echo "[ -s \"\$NVM_DIR/bash_completion\" ] && \\. \"\$NVM_DIR/bash_completion\" # This loads nvm bash_completion" >>~/.zshrc
	# bash
	echo "# Add nvm to PATH" >>~/.bashrc
	echo "export NVM_DIR=\"\$HOME/.nvm\"" >>~/.bashrc
	echo "[ -s \"\$NVM_DIR/nvm.sh\" ] && \\. \"\$NVM_DIR/nvm.sh\"                   # This loads nvm" >>~/.bashrc
	echo "[ -s \"\$NVM_DIR/bash_completion\" ] && \\. \"\$NVM_DIR/bash_completion\" # This loads nvm bash_completion" >>~/.bashrc
fi

# Install deno and add it to PATH
curl -fsSL https://deno.land/x/install/install.sh | sh
# zsh
echo "# Deno" >>~/.zshrc
echo "export DENO_INSTALL=$HOME/.deno" >>~/.zshrc
sed -Ei 's/PATH=(.+):$PATH/\1:$HOME/.deno/bin:$PATH/g' ~/.zshrc
# bash
echo "# Deno" >>~/.bashrc
echo "export DENO_INSTALL=$HOME/.deno" >>~/.bashrc
echo "export PATH=\$HOME/.deno/bin:\$PATH" >>~/.bashrc

# Install neovim
mkdir __temp
cd __temp
git clone https://github.com/neovim/neovim.git
# cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
cd neovim && make CMAKE_BUILD_TYPE=Release
# git checkout stable
sudo make install
rm -rf __temp

# Install packer.nvim (package manager)
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

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
