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

#export http_proxy="localhost:8118"

alias up='cd ..;'

# ls aliases
alias ls='ls -G --color=auto'
alias la='ls -vAB'
alias lv='ls -vB'
alias ll='ls -lvhB'
alias lal='ls -AvlhB'

function agentdock() {
    docker ps | grep agent | cut -d' ' -f1
}

function runagentdock() {
    docker exec -it $(agentdock) /bin/bash
}

function rmagentdock() {
   docker rm -f $(agentdock)
}

function m() {
    emacs $1 &
}

alias mn='emacs -nw'
alias sm='sudo emacs -nw'

alias vls='vault list'
alias vcat='vault read'

alias gc='git commit -S'
alias gs='git status'
alias gss='git stash save'
alias gsp='git stash pop'
alias gd='git diff'
alias grh='git reset --hard'
alias gb='git branch'
alias gbd='git branch -D'
alias gp='git push origin HEAD:forest/$(git rev-parse --abbrev-ref HEAD)'
alias gpl='git pull'
alias gnp='git --no-pager'
alias gg='git grep'
alias gnpd='gnp diff'
alias gnpg='gnp grep'

alias apti='sudo apt-get install'

alias yi='yarn install --check-files'
alias ytf='yarn testFast'
alias yt='yarn test'
alias ys='yarn start'

alias laponly='xrandr --output HDMI2 --off --output DP1 --off --output eDP1 --mode 1600x900'
alias allmons='xrandr --output DP1 --left-of eDP1 --mode 2560x1440 --output HDMI2 --left-of DP1 --auto --output eDP1 --mode 1600x900'

alias backendTest='SPECIAL_INSTANCE_ID=dev DEPLOYMENT=test NODE_ENV=dev grunt mochaTest'

function go() {
    cd ~/workspace/$1
}

function gnewb() {
    git fetch
    git checkout -b $1 origin/master
}

function gnewbs() {
    git fetch
    git checkout -b $1 origin/staging
}

alias sbfab='NODE_ENV=sandbox fab'
alias switchstaging='git pull && git reset origin/master && git stash save && git reset --hard origin/staging && git branch --set-upstream-to=origin/staging && git stash pop'

PATH=$HOME/.mongodb/install/bin:$HOME/bin:$PATH:$HOME/.rvm/bin:$HOME/workspace/smartcd/bin:$HOME/bin/wkhtmltox/bin # Add RVM to PATH for scripting


[ -r "$HOME/.smartcd_config" ] && ( [ -n $BASH_VERSION ] || [ -n $ZSH_VERSION ] ) && source ~/.smartcd_config

source ~/.git-completion.bash

export NODE_ENV=dev
export DEPLOYMENT=blend-borrower
export TENANT_LIST=blend-borrower
export VAULT_ADDR=https://vault.sandbox.centrio.com:8200
export ACCOUNT_ID=517567714695
export JENKINS_ENV=sandbox

GPG_TTY=$(tty)
export GPG_TTY

export PATH="$HOME/.yarn/bin:$PATH"
