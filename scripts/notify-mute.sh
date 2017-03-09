#!/bin/bash
notify-send -a pulseaudio -t 1000 "Mute Toggled" "<big>$(pactl list sinks | grep '^[[:space:]]Mute:' | tail -n 1)</big>"
