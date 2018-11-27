#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

case $1 in
  "i3" )
    BARTITLE=i3bar;;
  "bspwm" )
    BARTITLE=bspwm;;
  * )
    exit 1;;
esac

if type "xrandr" > /dev/null 2>&1; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    nohup env MONITOR=$m polybar $BARTITLE > /dev/null 2>&1 &
  done
else
  nohup polybar $BARTITLE > /dev/null 2>&1 &
fi

echo "Bars launched..."
