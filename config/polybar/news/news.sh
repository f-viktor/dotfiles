#!/bin/bash

#if its runing kill it
pgrep -x newsboat >/dev/null
if [ $? -eq 0 ]; then
   pkill -9 newsboat
else
   urxvt -e newsboat &
fi
