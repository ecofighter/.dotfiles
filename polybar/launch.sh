#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

case $1 in
  "i3" )
    polybar i3bar &;;
  "bspwm" )
    polybar bspwm &;;
  * )
    exit 1;;
esac

echo "Bars launched..."
