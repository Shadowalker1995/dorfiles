#!/bin/bash
SINK=$(pactl list short | grep RUNNING | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,')
STEP=5%

[[ "$1" == "Up" || "$1" == "+" ]] && pactl set-sink-volume $SINK +$STEP
[[ "$1" == "Down" || "$1" == "-" ]] && pactl set-sink-volume $SINK -$STEP

SINK_VOLUME=$(pactl list sinks | grep '^[[:space:]]音量：'| head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

# Display current Volume
[[ "$1" == "Up" || "$1" == "+" ]] && printf "Volume Up to " && echo $SINK_VOLUME && notify-send "Volume Up to "$SINK_VOLUME -t 500
[[ "$1" == "Down" || "$1" == "-" ]] && printf "Volume Down to " && echo $SINK_VOLUME && notify-send "Volume Down to "$SINK_VOLUME -t 500

SINK_VOLUME=$(pactl list sinks | grep '^[[:space:]]音量：'| head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
