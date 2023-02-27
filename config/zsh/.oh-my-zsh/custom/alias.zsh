# Questionable life decisions
# alias fuckyou='git push --force'

# Quality of life
alias mkd='f(){ mkdir "$1" && cd "$1" }; f'

alias sd='cd "$((fd . --type d | fzf) | sed "s/^$/""/")"'
alias sdh='cd "$((fd . --full-path ~ --type d | fzf) | sed "s/^$/""/")"'
alias sf='xdg-open "$((fd . --type f | fzf) | sed "s/^$/""/")" &> /dev/null'
alias sfh='xdg-open "$((fd . --full-path ~ --type f | fzf) | sed "s/^$/""/")" &> /dev/null'
# alias sdt='cd "$((fd . --type d | fzf) | sed "s/^$/""/")"'

# Kubernetes
alias kubectl="minikube kubectl --"

# Docker
alias dps="docker ps"
alias de="docker exec"
alias dei="docker exec -i"
alias deit="docker exec -it"

# Shortcuts
alias c="code"
alias c.="code ."
alias n="nvim"
alias n.="nvim ."
alias vim="nvim"
alias vimbegood="docker run -it --rm brandoncc/vim-be-good:latest"

# Git but weird
alias git-clear-permission-changes="git diff -p -R --no-ext-diff --no-color | grep -E \"^(diff|(old|new) mode)\" --color=never | git apply"

# npm
alias ni="npm install"
alias nid="npm install --save-dev"
alias nxr="npx run"
alias nxd="npx run dev"

# pnpm
alias pi="pnpm install"
alias pid="pnpm install -D"
alias pd="pnpm run dev"
alias pnpr="pnpm run"

# yarn
alias ya="yarn add"
alias yad="yarn add -d"
alias yd="yarn dev"
alias yi="yarn install"

# Yarn (Orbit)
alias ydn="yarn down"
alias yr="yarn rebuild"
alias yc="yarn console"
alias yhc="yarn hasura:console"
alias yel="yarn express:log"
alias yhl="yarn hasura:log"
alias yal="yarn all:log"
alias ym="yarn migrate"
alias yhm="yarn hasura:migrate"
