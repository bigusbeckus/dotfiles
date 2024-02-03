# Questionable life decisions
# alias fuckyou='git push --force'

# Quality of life
alias mkd='f(){ mkdir "$1" && cd "$1" }; f'

alias sd='cd "$((fd . --type d | fzf) | sed "s/^$/""/")"'
alias sdh='cd "$((fd . --full-path ~ --type d | fzf) | sed "s/^$/""/")"'
alias sdr='cd "$((fd . --full-path / --type d | fzf) | sed "s/^$/""/")"'
# alias sf='xdg-open "$((fd . --type f | fzf) | sed "s/^$/""/")" &> /dev/null' # No preview
# alias sfh='xdg-open "$((fd . --full-path ~ --type f | fzf) | sed "s/^$/""/")" &> /dev/null' # No preview
alias sf='xdg-open "$((fd . --type f | fzf --preview "cat {}" | xargs) | sed "s/^$/""/")" &> /dev/null' # With preview
alias sfh='xdg-open "$((fd . --full-path ~ --type f | fzf --preview "cat {}" | xargs) | sed "s/^$/""/")" &> /dev/null' # With preview
alias sfr='xdg-open "$((fd . --full-path / --type f | fzf) | sed "s/^$/""/")" &> /dev/null' # No preview
# alias sdt='cd "$((fd . --type d | fzf) | sed "s/^$/""/")"'

# Kubernetes
alias kubectl="minikube kubectl --"

# Docker
alias dps="docker ps"
alias de="docker exec"
alias dei="docker exec -i"
alias deit="docker exec -it"
alias docker-compose="docker compose"
# alias docker-clean-dangling="docker images -f \"dangling=true\" -q | docker rmi"

# Docker db
alias createpgdb='f() { local __user; if [ -z $3 ]; then __user=postgres; else __user=$3; fi; docker exec -i $1 createdb -U $__user $2; unset -f f; }; f'
alias droppgdb='f() { local __user; if [ -z $3 ]; then __user=postgres; else __user=$3; fi; docker exec -i $1 dropdb -U $__user $2; unset -f f; }; f'
alias lspgdb='f() { local __user; if [ -z $2 ]; then __user=postgres; else __user=$2; fi; docker exec -i $1 psql -U $__user -l; unset -f f; }; f'
alias dumppgdb='f() { local __user; if [ -z $3 ]; then __user=postgres; else __user=$3; fi; docker exec -i $1 pg_dump -U $__user -d $2; unset -f f; }; f'

# Shortcuts
alias c="codium"
alias c.="codium ."
# alias c="code"
# alias c.="code ."
alias n="nvim"
alias n.="nvim ."
alias t="tmux"
alias vim="nvim"
alias vimbegood="docker run -it --rm brandoncc/vim-be-good:latest"

# Git but weird
alias git-clear-permission-changes="git diff -p -R --no-ext-diff --no-color | grep -E \"^(diff|(old|new) mode)\" --color=never | git apply"

# npm
alias ni="npm install"
alias nid="npm install --save-dev"
alias nr="npm run"
alias nd="npm run dev"

# pnpm
alias pi="pnpm install"
alias pid="pnpm install -D"
alias pd="pnpm run dev"
alias pnpr="pnpm run"
alias prm="pnpm remove"

# bun
alias bi="bun install"
alias bid="bun install -D"
alias bd="bun run dev"
alias bnpr="bun run"
alias brm="bun remove"

# yarn
alias ya="yarn add"
alias yad="yarn add -d"
alias yd="yarn dev"
alias yi="yarn install"
alias yrm="yarn remove"

# Yarn (Hasura)
alias ydn="yarn down"
alias yr="yarn rebuild"
alias yc="yarn console"
alias yhc="yarn hasura:console"
alias yel="yarn express:log"
alias yhl="yarn hasura:log"
alias yal="yarn all:log"
alias ym="yarn migrate"
alias yhm="yarn hasura:migrate"

# pnpm (Hasura)
alias pdn="pnpm down"
alias pr="pnpm rebuild"
alias pc="pnpm console"
alias phc="pnpm hasura:console"
alias pel="pnpm express:log"
alias pal="pnpm all:log"
alias pm="pnpm migrate"

# Go
alias gor="go run"
alias gor.="go run ."
alias goi="go mod tidy"
alias gom="go mod"
alias gomd="go mod download"
alias gomi="go mod init"
alias gomt="go mod tidy"
alias gomv="go mod vendor"
