#!/bin/bash

FLAG=

function reload_nb {
	pgrep -x newsboat >/dev/null && \
		echo "newsboat open" \
		|| echo $FLAG $(newsboat -x reload print-unread | awk '{print $1}')
	notify-send "Newsboat updated"
}

function refresh_nb {
        echo $FLAG $(newsboat -x print-unread | awk '{print $1}')
}


if [[ -z "${BLOCK_BUTTON}" ]]; then
	reload_nb
else 
   case $BLOCK_BUTTON in
   1)  #if its runing kill it
	pgrep -x newsboat >/dev/null
	if [ $? -eq 0 ]; then
	   pkill -9 newsboat
	   refresh_nb
	else
	   refresh_nb
           urxvt -e newsboat &
        fi;;
   *)   reload_nb;;
   esac
fi
