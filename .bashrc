 export NVM_DIR="/home/forest/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # ~/.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# append to the history file, don't overwrite it. also, do so on every command (don't lose history)
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
shopt -s extglob

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export PATH=$PATH:/usr/bin/scripts:/usr/local/qtcreator-2.6.1/bin:/usr/local/mpich-3.0.1/bin:~/bin/android-sdk/tools:~/bin/android-sdk/platform-tools:~/bin/django:~/workspace/npm-shrinkwrap/bin
export EDITOR="emacs"

export JAVA_HOME=/usr/lib/jvm/java-7-openjdk/
export _JAVA_AWT_WM_NONREPARENTING=1

export AWS_VAULT_BACKEND=secret-service

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

#export http_proxy="localhost:8118"

alias up='cd ..;'

# ls aliases
alias ls='ls -G --color=auto'
alias la='ls -vAB'
alias lv='ls -vB'
alias ll='ls -lvhB'
alias lal='ls -AvlhB'

function dockerprocessname() {
    docker ps | grep $1 | cut -d' ' -f1
}

function sshdocker() {
    docker exec -it $(dockerprocessname $1) /bin/bash
}

function rmdocker() {
   docker rm -f $(dockerprocessname $1)
}

function m() {
    emacs $1 &
}

function addCtx() {
    file=$1
    pathToTypes=`echo backend/lib/accountOpening/external/accountOpeningService.ts | sed -E -e 's|backend/||' -e '/^lib/! s|^[^/]+/|../lib/|' -e 's|lib/||' -e 's|[^/]+/|../|g' -e 's|/[^/]*\.\w{2}|/types|'`
    fileExtension=`echo $file | sed -E -e 's|.*\.(\w{2})|\1|`
    echo -e "import { Ictx } from ${pathToTypes};"`cat $file` > $file
}

alias mn='emacs -nw'
alias sm='sudo emacs -nw'

alias vls='vault list'
alias vcat='vault read'

alias apti='sudo apt-get install'

alias ytf='npm run testFast'
alias yt='npm test'
alias ys='npm start'

alias laponly='xrandr --output HDMI-2 --off --output DP-1 --off --output eDP-1 --mode 1600x900'
alias allmons='xrandr --output DP-1 --left-of eDP-1 --mode 3840x2160 --output HDMI-2 --left-of DP-1 --auto --rotate left --output eDP-1 --mode 1600x900'

alias backendTest='SPECIAL_INSTANCE_ID=dev DEPLOYMENT=test NODE_ENV=dev grunt mochaTest'

export VAULT_ADDR=https://vault.sandbox.k8s.centrio.com:8200
function vault_token() {
    CLIENT_ID=`cat ~/.deployinator_api_key  | jq -r '."Client-Id"'`
    CLIENT_SECRET=`cat ~/.deployinator_api_key  | jq -r '."Client-Secret"'`
    export VAULT_TOKEN=`curl -X POST https://deployinator.sandbox.k8s.centrio.com/api/vault.tokens -H "Client-Id: ${CLIENT_ID}" -H "Client-Secret: ${CLIENT_SECRET}" | jq -r '.token'`
}

function j() {
    cd ~/workspace/$1
}

function jg() {
    cd ~/workspace/gopath/src/golang.blend.com/project/$1
}
alias jlb='j lending/backend'
alias jinf='j infrastructure'

# git utilities
alias gc='git commit -S'
alias gs='git status'
alias gss='git stash save'
alias gsp='git stash pop'
alias gd='git diff'
alias grh='git reset --hard'
alias gb='git branch'
alias gbd='git branch -D'
alias gp='git push origin HEAD:$(whoami)/$(git rev-parse --abbrev-ref HEAD)'
alias gpl='git pull'
alias gnp='git --no-pager'
alias gg='git grep'
alias gnpd='gnp diff'
alias gnpg='gnp grep'
alias switchstaging='git pull && git reset origin/master && git stash save && git reset --hard origin/staging && git branch --set-upstream-to=origin/staging && git stash pop'
alias mergehacks='git pull && git push origin HEAD:master'

function gnewb() {
    git fetch
    git checkout -b $1 origin/master
}

function gnewbs() {
    git fetch
    git checkout -b $1 origin/staging
}

alias ywc='npm run watchCompile'
alias ytw='npm run testWatch'
alias ysr='npm run startNoRecompile'
alias ys='npm start'

alias avx='unset AWS_VAULT; aws-vault exec'
alias avxl='unset AWS_VAULT; aws-vault exec lending-dev --duration=8h'

source ~/.git-completion.bash

alias sbfab='NODE_ENV=sandbox fab'

PATH=$HOME/.mongodb/instalfl/bin:$HOME/bin:$PATH:$HOME/.rvm/bin:$HOME/workspace/smartcd/bin:$HOME/bin/wkhtmltox/bin # Add RVM to PATH for scripting


[ -r "$HOME/.smartcd_config" ] && ( [ -n $BASH_VERSION ] || [ -n $ZSH_VERSION ] ) && source ~/.smartcd_config

export NODE_ENV=dev
export SERVICE_ENV=dev
export DEPLOYMENT=blend-borrower
export TENANT_LIST=blend-borrower
export ACCOUNT_ID=517567714695
export JENKINS_ENV=sandbox

export GPG_TTY=$(tty)

export GOPATH="$HOME/workspace/gopath"
export PATH="$HOME/.local/bin:$PATH:/usr/local/go/bin:${GOPATH//://bin:}/bin"
