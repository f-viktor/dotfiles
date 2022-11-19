#!/bin/sh
export DISPLAY=:0

#make keypress repetition faster
xset r rate 300 100 &
#disable mouse accel
xset m 1/1 0 &

xmodmap /home/pepe/.Xmodmap
