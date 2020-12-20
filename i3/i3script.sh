#!/bin/bash

# shell scipt to prepend i3status with more stuff

i3status --config ~/.config/i3status/i3status.conf | while :
do
    read line
    lg=$(setxkbmap -query | awk '/layout/{print $2}')
    LG="${lg^^}"
    if [ $LG == "US" ]
    then
        dat="[{ \"full_text\": \"LG: $LG\", \"color\":\"#009E00\" },"
    else
        dat="[{ \"full_text\": \"LG: $LG\", \"color\":\"#C60101\" },"
    fi
    echo "${line/[/$dat}" || exit 1
done
