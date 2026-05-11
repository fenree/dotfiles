#!/usr/bin/env sh
#st -t float -g 50x13

cachedir="${XDG_CACHE_HOME:-"$HOME/.cache"}"
[ ! -e "$cachedir" ] && mkdir -p "$cachedir"
cache="$cachedir/dmenu_run" # this is just a textfile


IFS=: 
if stest -dqr -n "$cache" $PATH; then # -n checks if any directories in $cache are newer than values in $PATH
	PROG=$((IFS=:; stest -flx $PATH) | tee "$cache" | fzf --algo=v1 --ansi --tiebreak=length)
else
	PROG=$(cat "$cache" | fzf --algo=v1 --ansi --tiebreak=length)
fi
[ -n "$PROG" ] && setsid "$PROG" &
sleep 0.1
