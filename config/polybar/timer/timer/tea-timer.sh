#!/bin/bash

### Looksely based on:   https://github.com/jbirnick/polybar-timer

## FUNCTIONS

now () { date --utc +%s; }

killTimer () { rm -rf /tmp/polybar-timer ; }
timerRunning () { [ -e /tmp/polybar-timer/running ] ; }
timerExists () { [ -e /tmp/polybar-timer ] ; }
timerStart () { echo "1" > /tmp/polybar-timer/running ; }

timerExpiry () { cat /tmp/polybar-timer/expiry ; }
timerLabel () { cat /tmp/polybar-timer/label ; }
timerAction () { cat /tmp/polybar-timer/action ; }
timerRemaining () { cat /tmp/polybar-timer/remaining ; }

secondsLeft () { echo $(( $(timerExpiry) - $(now) )) ; }

updateTail () {
  if timerRunning && [ $(secondsLeft) -le 0 ]
  then
    echo "${STANDBY_LABEL}"
    eval $(timerAction < /dev/null)

    killTimer
  fi

  if timerRunning
  then
    echo "$(timerLabel) $(secondsLeft)"
  else
    echo "${STANDBY_LABEL} $(timerRemaining)"
  fi
}

## MAIN CODE

case $1 in
  tail)
    STANDBY_LABEL=$2

    trap updateTail USR1

    while true
     do
     updateTail
     if timerRunning
     then
       sleep 1 &
     else
       sleep 10 &
     fi
     wait
    done
    ;;
  update)
    kill -USR1 $(pgrep --oldest --parent ${2})
    ;;
  start)
    echo "$(( $(timerRemaining) + $(now) ))" > /tmp/polybar-timer/expiry
    timerStart
    ;;
  increase)
    if timerExists
    then
      echo "$(( $(cat /tmp/polybar-timer/remaining) + ${2} ))" > /tmp/polybar-timer/remaining
    else
      killTimer
      mkdir /tmp/polybar-timer
      echo "${2}" > /tmp/polybar-timer/remaining
      echo "${3}" > /tmp/polybar-timer/label
      echo "${4}" > /tmp/polybar-timer/action
    fi
    ;;
  cancel)
    killTimer
    ;;
  *)
    echo "tea-timer broke due to invalid argument: $1"
    ;;
esac
