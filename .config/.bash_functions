mkcd() {
    mkdir -p $@ && cd ${!#}
}

j() {
	export FZF_DEFAULT_COMMAND="fd -c always -d 5 -td -tf --no-require-git '.*'"
    P=$(fzf-tmux --algo=v1 --ansi --tiebreak=length)
	if [ -d $P ]; then 
		pushd $P 2>/dev/null
	elif [ -r $P ]; then
		$VISUAL $P
	fi	
}


