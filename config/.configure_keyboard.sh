#!/bin/sh
export DISPLAY=:0

#make keypress repetition faster
xset r rate 300 100 &
#disable mouse accel
xset m 1/1 0 &

xmodmap /home/pepe/.Xmodmap


#https://wiki.archlinux.org/title/Bluetooth#Wake_from_suspend
# this also needs to happen if you want it on login: https://wiki.archlinux.org/title/Bluetooth#Discoverable_on_startup
