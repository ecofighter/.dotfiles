#!/bin/bash
sinknum=$(pactl list sinks short | tail -n 1 | grep -o '^[0-9]')
pactl set-sink-mute $sinknum toggle
notify-send -u low -a pulseaudio -t 500 "Mute Toggled" "<big>$(pactl list sinks | grep '^[[:space:]]Mute:' | tail -n 1)</big>"
