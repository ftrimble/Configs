 export NVM_DIR="/home/forest/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # ~/.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

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

alias mn='emacs -nw'
alias sm='sudo emacs -nw'

alias ytf='npm run testFast'
alias yt='npm test'
alias ys='npm start'

function j() {
    cd ~/workspace/athena$1
}

# git utilities
alias gc='git commit -S'
alias gs='git status'
alias gss='git stash save'
alias gsp='git stash pop'
alias gd='git diff'
alias grh='git reset --hard'
alias gb='git branch'
alias gbd='git branch -D'
alias gp='git push origin HEAD:$(git rev-parse --abbrev-ref HEAD)'
alias gpl='git fetch && git merge origin/main'
alias gnp='git --no-pager'
alias gg='git grep'
alias gnpd='gnp diff'
alias gnpg='gnp grep'
alias switchstaging='git pull && git reset origin/master && git stash save && git reset --hard origin/staging && git branch --set-upstream-to=origin/staging && git stash pop'
alias mergehacks='git pull && git push origin HEAD:master'

function gnewb() {
    git fetch
    git checkout -b $1 origin/main
}

function gcp() {
    gc -am $1
    gp
}

function awsl() {
    export AWS_PROFILE=$1
    aws sso login
}
alias awslp='awsl sandbox-power'
alias awsla='awsl sandbox-admin'

alias mlf='make format lint-fix'

alias ywc='npm run watchCompile'
alias ytw='npm run testWatch'
alias ysr='npm run startNoRecompile'
alias ys='npm start'

function as() {
    APPLICANT_UI_PORT=300$1 BACKEND_PORT=800$1 make dev-applicant
}

PATH=$HOME/.mongodb/instalfl/bin:$HOME/bin:$PATH:$HOME/.rvm/bin:$HOME/workspace/smartcd/bin:$HOME/bin/wkhtmltox/bin # Add RVM to PATH for scripting


export NODE_ENV=dev
export SERVICE_ENV=dev

export GPG_TTY=$(tty)

export GOPATH="$HOME/workspace/gopath"
export PATH="$HOME/.local/bin:$PATH:/usr/local/go/bin:${GOPATH//://bin:}/bin"
export PATH="/opt/homebrew/opt/postgresql@14/bin:$PATH"

export ENVIRONMENT="local"

export DATABASE_URL=postgresql://athena_user:athena_password@localhost:5432/athena

autoload -Uz compinit && compinit

bindkey -e

export WORDCHARS='*?[]~/&;!$%^(){}<>'

eval "$(starship init zsh)"
