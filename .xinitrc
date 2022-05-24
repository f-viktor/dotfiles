if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#make keypress repetition faster    
xset r rate 300 100 &   
#disable mouse accel    
xset m 1/1 0 &

xset dpms 3600 3600 3600 & # set timeout to 1 hour
xset s off & # Disables screen saver

exec i3
