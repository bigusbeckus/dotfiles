### Tools list

|     | #   | Package/Program | Command (`apt` for Ubuntu, `dnf` for Fedora)                                                                             |
| --- | --- | --------------- | ------------------------------------------------------------------------------------------------------------------------ |
| [x] | 1   | curl            | `sudo apt install curl -y`                                                                                               |
| [-] | 2   | git             | `sudo apt install git -y`                                                                                                |
| [x] | 3   | zsh             | `sudo apt install zsh -y`                                                                                                |
| [-] | 4   | oh-my-zsh       | `sh -c -- -y "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`                  |
| [x] | 5   | gcc             | `sudo apt install gcc -y`                                                                                                |
| [x] | 6   | gcc-c++         | `sudo apt install gcc-c++ -y`                                                                                            |
| [x] | 7   | make            | `sudo apt install make -y`                                                                                               |
| [x] | 8   | cargo           | `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \| sh -s -- -y`                                               |
| [x] | 9   | tree-sitter     | `cargo install tree-sitter`                                                                                              |
| [x] | 10  | tree-sitter-cli | `cargo install tree-sitter-cli`                                                                                          |
| [x] | 11  | brew            | Has script for path so check docs                                                                                        |
| [x] | 12  | fd              | `brew install fd`                                                                                                        |
| [x] | 13  | ripgrep         | `brew install ripgrep`                                                                                                   |
| [x] | 14  | fzf             | `brew install fzf`                                                                                                       |
| [x] | 15  | nvm             | Weird version stuff and has script for path so check docs                                                                |
| [ ] | 16  | node            | `nvm install --lts`                                                                                                      |
| [x] | 17  | npm@latest      | `npm install -g npm@latest`                                                                                              |
| [x] | 18  | pnpm            | `npm install -g pnpm`                                                                                                    |
| [ ] | 19  | go              | Weird version stuff and has script for path so check docs                                                                |
| [x] | 20  | deno            | Check docs                                                                                                               |
| [ ] | 21  | neovim          | Clone from master, build, add to `/usr/local/bin`                                                                        |
| [ ] | 22  | packer.nvim     | `git clone --depth 1 <https://github.com/wbthomason/packer.nvim> ~/.local/share/nvim/site/pack/packer/start/packer.nvim` |
| [ ] | 23  | Nerd fonts      | Put files in a `.fonts` folder in the `$HOME` directory (Fira Code and JetBrains Mono)                                   |
| [ ] | 24  | docker          | [Ubuntu](https://docs.docker.com/desktop/install/ubuntu/), [Fedora](https://docs.docker.com/desktop/install/fedora/)     |
| [ ] | 25  | bun             | `curl -fsSL <https://bun.sh/install> \| bash`                                                                            |

### Notes

- You can get the latest latest release for apps where the version number is hard coded into the install script using the github api:

> **Example:**  
> To get info on the latest nvm release:  
> `https://api.github.com/repos/nvm-sh/nvm/releases/latest`

### Old

- curl
- git (from `apt` or `dnf`)
- zsh (from `apt` or `dnf`)
- oh-my-zsh (may be able to just copy rc files)
- gcc
- gcc-c++
- make
- cargo
- tree-sitter
- tree-sitter-cli
- brew
- fd (from homebrew)
- rg ([ripgrep](https://github.com/BurntSushi/ripgrep))
- fzf
- nvm
- node (LTS)
- npm@latest
- pnpm
- go
- deno
- neovim
- packer.nvim
- Nerd fonts (Fira Code and JetBrains Mono)
  - Put in a `.fonts` folder in the `$HOME` directory
