#!/bin/dash

xclip -selection clipboard -out | tr \\n \\r | xdotool getwindowfocus type --clearmodifiers --delay 5 --window %@ --file -
