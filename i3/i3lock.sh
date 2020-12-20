#!/bin/bash

# Take a screenshot
scrot /tmp/screen_locked.png

# Pixellate it 10x
#mogrify -scale 10% -scale 1000% /tmp/screen_locked.png

# Blur it 2px
convert /tmp/screen_locked.png -blur 2x2 /tmp/screen_locked2.png

# Lock screen displaying this image.
i3lock -d -i /tmp/screen_locked2.png
