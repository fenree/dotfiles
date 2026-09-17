#!/bin/sh
# Backup these variables cuz they may change
CWD=$(pwd)

CACHE_DIR="${XDG_CACHE_HOME:-"$HOME/.cache"}"
[ ! -e "$CACHE_DIR" ] && mkdir -p "$CACHE_DIR"

# jump is not usefully intergrated yet.
FIND_HIST="${CACHE_DIR}/.find_history"
GREP_HIST="${CACHE_DIR}/.grep_history"
JUMP_HIST="${CACHE_DIR}/.jump_history"

trap "cd ${OLDPWD}; cd ${PWD}; export FZF_DEFAULT_COMMAND='${FZF_DEFAULT_COMMAND}'; trap - EXIT INT" EXIT INT

while [ $# -gt 0 ]; do
	case $1 in
		-d) [ -d "$2" ] && cd "$2"; D=$2 ; shift ;;
		-I) RGARGS="$RGARGS --no-ignore";;
		--vim) ED="vim" ;;
		-q) Q="$2" ; shift ;;
		*) echo "$1 is an invalid argument" ; exit 1 ;;
	esac; shift
done

case "$ED" in
	vim) 
		ENTER="[ -d {1} ] && CMD='cd\\ ' || [ -r {1} ] && CMD='edit +call\ cursor({2},{3})'; echo \"\$CMD ${CWD}/{1}\"| tr -d \\'" 
		[ -z "$D" ] && D=5
		export FZF_DEFAULT_COMMAND="fd -c always -d $D -td -tf -j$(nproc) --no-require-git '.*'"
		;;

	*)	
		ENTER="[ -d {1} ] && cd {1} 2>/dev/null || [ -r {1} ] && nvim {1} +{2}" 
		[ -z "$D" ] && D=5
		export FZF_DEFAULT_COMMAND="fd -c always -d $D -td -tf -j$(nproc) --no-require-git '.*'"
		;;
esac

# remove leading space
R="rg ${RGARGS# } -j$(nproc) --color=always --smart-case --column {q}"
set -f 
set -- --disabled --ansi --tmux 85% --algo=v1 --ansi --tiebreak=length --tail 100000 \
	--bind "enter:become:$ENTER" \
	--bind "start:reload(${R})+unbind(ctrl-r)" \
	--bind "change:reload:sleep 0.1;${R} || :" \
	--bind "ctrl-b:become:git blame {1} | awk 'NR=='{2}'{print \$1;exit}'" \
	--bind "ctrl-g:transform:[ \"\$FZF_PREVIEW_LABEL\" = 'blame' ] && echo 'change-preview-label(bat)+change-preview(bat --style=full --color=always --highlight-line {2} {1})' || echo 'change-preview-label(blame)+change-preview(git blame -L {2},+10 {1})'"\
    --bind "ctrl-f:unbind(change,ctrl-f)+enable-search+rebind(ctrl-r)+transform-query(echo {q} > ${GREP_HIST} ; awk END{print} ${FIND_HIST})" \
	--bind "ctrl-j:unbind(change,ctrl-j)+enable-search+rebind(ctrl-r,ctrl-f)+transform-query([ ${GREP_HIST} -nt ${FIND_HIST} ] && echo {q} >> ${FIND_HIST} || echo {q} >> ${GREP_HIST} ; awk END{print} ${JUMP_HIST})" \
    --bind "ctrl-r:unbind(ctrl-r)+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)+transform-query(echo {q} >> ${FIND_HIST} ; awk END{print} ${GREP_HIST})" \
	--delimiter : ${ARGS# } --query "$Q"
set +f

fzf "$@" --with-nth=1,2 \
	--preview-label 'bat' \
	--preview 'bat --style=full --color=always --highlight-line {2} {1}'\
	--preview-window "~4,+{2}+4/3,<80(right)"



