#!/usr/bin/bash

MONITORS=$(xrandr --query | grep " connected" | cut -d" " -f1)
MONITORS_USED=$(xrandr --query | grep -e " connected.*[0-9]x" | wc -l)
HAS_VIRTUAL=$(echo $MONITORS | grep "VIRTUAL")

  if test $(echo $MONITORS | wc -w) -gt 1; then
    if [ $MONITORS_USED -gt 1 ]; then
      xrandr --output HDMI2 --off;
      $HOME/.config/polybar/launch.sh i3;
    else
      xrandr --output HDMI2 --auto --right-of eDP1;
      $HOME/.config/polybar/launch.sh i3;
    fi
  else
    xrandr --output HDMI2 --auto --right-of eDP1;
    $HOME/.config/polybar/launch.sh i3;
  fi

echo $MONITORS
echo $MONITORS_USED
echo $HAS_VIRTUAL
