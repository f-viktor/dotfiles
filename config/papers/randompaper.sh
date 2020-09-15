#!/bin/bash

RND1=$( ls $1 | shuf -n 1)
PAPER1="$1/$RND1"

RND2=$( ls $2 | shuf -n 1)
PAPER2="$2/$RND2"

feh --bg-fill "$PAPER1" --bg-fill "$PAPER2" 

multilockscreen --display 3 --fx dimblur -u "$PAPER1" -u "$PAPER2" > /home/pepe/.config/papers/multilock_log
