#!/bin/bash
SINK_NAME=$(pactl info | grep '默认音频入口' | sed -e 's,默认音频入口：,,')
#SINK=$(pactl list short | grep $SINK_NAME | tail -n 1 | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,')
SINK=$(pactl list short | grep RUNNING | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,')
STEP=5%

#[[ "$1" == "Up" || "$1" == "+" ]] && pactl set-sink-volume $SINK +$STEP
#[[ "$1" == "Down" || "$1" == "-" ]] && pactl set-sink-volume $SINK -$STEP

[[ "$1" == "Up" || "$1" == "+" ]] && amixer -D pulse sset Master $STEP+
[[ "$1" == "Down" || "$1" == "-" ]] && amixer -D pulse sset Master $STEP-

#SINK_VOLUME=$(pactl list sinks | grep -A 10 $SINK_NAME | grep '^[[:space:]]音量：'| head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
#SINK_VOLUME=$(pactl list sinks | grep -A 10 RUNNING | grep '^[[:space:]]音量：'| head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
SINK_VOLUME=$(amixer -D pulse sget Master | tail -n 1 | sed -e 's,.*\[\(.*\)%\].*,\1,')

# Display current Volume
[[ "$1" == "Up" || "$1" == "+" ]] && printf "Volume Up to " && echo $SINK_VOLUME && notify-send "Volume Up to "$SINK_VOLUME -t 500
[[ "$1" == "Down" || "$1" == "-" ]] && printf "Volume Down to " && echo $SINK_VOLUME && notify-send "Volume Down to "$SINK_VOLUME -t 500

