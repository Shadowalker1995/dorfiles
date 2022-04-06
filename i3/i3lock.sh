#!/bin/bash

FILE="/tmp/screen_locked.png"
FILE_BLUR="/tmp/screen_locked2.png"

if [[ -f "$FILE" ]]
then
    rm "$FILE"
fi

# Take a screenshot
scrot "$FILE"

# Pixellate it 10x
#mogrify -scale 10% -scale 1000% /tmp/screen_locked.png

# Blur it 2px
convert "$FILE" -blur 2x2 "$FILE_BLUR"

# Lock screen displaying this image.
i3lock -d -i "$FILE_BLUR"
