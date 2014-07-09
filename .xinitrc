#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
. scripts/shfunctions.sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

setxkbmap -option ctrl:swapcaps


while true; do
    xsetroot -name "$(tod) | $(battery) | $(volume)"
    sleep 1m # update status every minute
done &

xbindkeys

synclient TouchpadOff=1

exec dwm
