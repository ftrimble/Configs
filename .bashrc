# ~/.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export PATH=$PATH:/usr/bin/scripts:/usr/local/qtcreator-2.6.1/bin:/usr/local/mpich-3.0.1/bin:~/bin/android-sdk/tools:~/bin/android-sdk/platform-tools:~/bin/django
export EDITOR="emacs -nw"

export JAVA_HOME=/usr/lib/jvm/java-7-openjdk/
export _JAVA_AWT_WM_NONREPARENTING=1

#export http_proxy="localhost:8118"

alias up='cd ..'

# ls aliases
alias la='ls -vAB'
alias lv='ls -vB'
alias ll='ls -lvhB'
alias lal='ls -AvlhB'

# apt aliases

alias pac='sudo pacman'
alias pacr='sudo pacman -Rs'
alias pacs='sudo pacman -Sy'
alias pacsrch='sudo pacman -Ss'
alias pacq='sudo pacman -Q'
alias paclo='sudo pacman -Qdt'
alias pacu='sudo pacman -U'
alias pacsys='sudo pacman -Syyu'

function m() {
    emacs $1 &
}
function sm() {
    sudo emacs -nw $1
}
function mn() {
    emacs -nw $1
}

alias | sed -E "s/^alias ([^=]+)='(.*)'$/alias \1 \2 \$*/g; s/'\\\''/'/g;" >~/.emacs.d/eshell/alias

function class() {
    if [ "$1" == "ai" ]; then
        cd ~/Documents/School/csci/4150
    elif [ "$1" == "db" ]; then
        cd ~/Documents/School/csci/4380/
    elif [ "$1" == "bio" ]; then
        cd ~/Documents/School/biol/1010/
    fi

}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

