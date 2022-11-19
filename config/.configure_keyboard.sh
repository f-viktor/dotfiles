#!/bin/sh
{
sleep 2
export DISPLAY=:0
export XAUTHORITY=/home/pepe/.Xauthority
#make keypress repetition faster
xset r rate 300 100 
#disable mouse accel
xset m 1/1 0 

xmodmap /home/pepe/.Xmodmap 
} &

#https://wiki.archlinux.org/title/Bluetooth#Wake_from_suspend
# this also needs to happen if you want it on login: https://wiki.archlinux.org/title/Bluetooth#Discoverable_on_startup

# two seconds is the magic number that makes it work, any more or less, and it breaks ¯\_(ツ)_/¯
