#!/bin/bash
if [ $(playerctl -p rhythmbox status) = "Paused" ]; then notify-send 'Player Paused'; fi
