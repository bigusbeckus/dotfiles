# Init

Automates program installation and configuration on fresh linux installs (ubuntu and fedora supported).

### Prerequisites

It is recommended to clone the repo using git but downloading it as a zip file will also do.

```sh
sudo apt install git
git clone https://github.com/bigusbeckus/dotfiles.git
```

### Installation

Run the script starter file with

```
cd init
./start.sh
```

**Note:** The script requires admin privileges and will periodically prompt you for the password. For an unattended run, you can store your password in a file and pipe it to the script.

```
cat file_with_password.txt | ./start.sh
```

> Do not use `echo` to pass the sudo password to the script as that will leave your password in the command history.

### Notes

- You can get the latest release for apps where the version number is hard coded into the install script using the github api:

  **Example:** To get info on the latest nvm release:  
  `https://api.github.com/repos/nvm-sh/nvm/releases/latest`

- Docker engine is different from docker desktop. We want engine.

### To-Do

- Nerd fonts

  > Put .ttf files in a `.fonts` folder in the `$HOME` directory

  Fonts:

  - Fira Code
  - JetBrains Mono

- docker

  - [Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
  - [Fedora](https://docs.docker.com/engine/install/fedora/)

  > Don't forget to perform the [postinstall steps](https://docs.docker.com/engine/install/linux-postinstall/)

### Done

- curl
- git
- zsh
- oh-my-zsh
- gcc
- gcc-c++
- make
- cargo
- tree-sitter
- tree-sitter-cli
- brew
- fd
- ripgrep
- fzf
- nvm
- node
- npm@latest
- pnpm
- yarn
- go
- deno
- neovim
- packer.nvim
- bun
