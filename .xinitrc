#!/bin/sh

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# status bar
~/myarch/statusbar.sh &

# background
~/.fehbg &

# automount/unmount
udiskie &

# dwm loop
while true; do
	dwm >/dev/null 2>&1
done

# execute dwm
exec dwm
