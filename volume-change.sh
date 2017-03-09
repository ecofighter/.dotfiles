#!/bin/bash
sinknum=$(pactl list sinks short | tail -n 1 | grep -o '^[0-9]')
pactl set-sink-mute $sinknum false
pactl set-sink-volume $sinknum "$1"5%
notify-send -u low -a pulseaudio -t 500 "Volume Changed" "<big>"$(pactl list sinks | grep "^[[:space:]]Volume:" | tail -n 1 | sed -e "s,.* \([0-9][0-9]*\)%.*,\1,")%"</big>"
