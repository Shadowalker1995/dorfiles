#!/bin/bash
#SINK=$(pactl list short | grep RUNNING | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,')

#pactl set-sink-mute $SINK toggle && notify-send 'Volumn Mute' -t 500
amixer -D pulse sset Master toggle && STATUS=$(amixer -D pulse sget Master | tail -n 1 | sed -e 's,.*\[\(.*\)\].*,\1,') && notify-send 'Volumn '$STATUS -t 500
