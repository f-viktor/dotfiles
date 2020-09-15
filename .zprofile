clear
export ZDOTDIR="$HOME/.config/zsh"

#start graphical server if i3 not already running.
if [ "$(tty)" = "/dev/tty1" ]; then
		pgrep -x i3 || exec startx
fi
