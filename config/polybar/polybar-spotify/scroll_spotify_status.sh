#!/bin/bash


# see man zscroll for documentation of the following parameters
PLAYER=spotify

PLAYERCTL_STATUS=$(playerctl --player=$PLAYER status 2>/dev/null)
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then

zscroll -l 30 \
        --delay 0.1 \
        --scroll-padding " ♪ " \
        --match-command "$HOME/.config/polybar/polybar-spotify/get_spotify_status.sh --status" \
        --match-text "Playing" "--scroll 1" \
        --match-text "Paused" "--scroll 0" \
        --update-check true "$HOME/.config/polybar/polybar-spotify/get_spotify_status.sh" &
wait

else
    echo ""
fi
