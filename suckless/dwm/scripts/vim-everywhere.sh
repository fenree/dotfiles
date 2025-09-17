#!/bin/dash
TMPFILE=$(mktemp)
nvim "$TMPFILE"
if [ -s "$TMPFILE" ]; then
	sleep 0.1
	xdotool type "$(cat "$TMPFILE")"
fi
rm "$TMPFILE"
