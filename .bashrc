export NVM_DIR="/Users/foresttrimble/.nvm"
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

alias up='cd ..'

# ls aliases
alias ls='ls -G'
alias la='ls -vAB'
alias lv='ls -vB'
alias ll='ls -lvhB'
alias lal='ls -AvlhB'

alias m='emacs'
alias sm='sudo emacs'
alias gc='git commit -S'
alias gp='git push origin HEAD:forest/$(git rev-parse --abbrev-ref HEAD)'

alias sbfab='NODE_ENV=sandbox fab'

PATH=$HOME/bin:$PATH:$HOME/.rvm/bin:$HOME/workspace/smartcd/bin # Add RVM to PATH for scripting


[ -r "$HOME/.smartcd_config" ] && ( [ -n $BASH_VERSION ] || [ -n $ZSH_VERSION ] ) && source ~/.smartcd_config

export NODE_ENV=dev
export DEPLOYMENT=blend-borrower
export VAULT_ADDR=https://vault.sandbox.centrio.com:8200

GPG_TTY=$(tty)
export GPG_TTY
