#!/bin/bash
notify-send -a pulseaudio -t 1000 "Volume Changed" "<big>"$(pactl list sinks | grep "^[[:space:]]Volume:" | tail -n 1 | sed -e "s,.* \([0-9][0-9]*\)%.*,\1,")%"</big>"
