mkcd() {
    mkdir -p $@ && cd ${!#}
}

fddrc() {	
    cd "$HOME"
    fd -c always -d 1 -sH -tf -j$(nproc) '^\..*(rc|\.conf)' -E '*.backup' -E '*.tmp'
    fd -c always -d 2 -sH -tf -j$(nproc) '\.(|bash_.*|rc|conf|vim|lua)$' -E '*.backup' -E '*.tmp' '.config/'
    cd -
}

eddrc() {
    P=$(fdrc | fzf --tmux 80% \
	    	 --algo=v1 \
		 --ansi \
	 	 --tiebreak=length \
		 --tail 100000 \
		 --preview 'bat --color=always {}')
    [ -n "${P}" ] && vim "${P}"
}

j() {
	local FZF_OLD_DEFAULT_COMMAND="$FZF_DEFAULT_COMMAND"
	export FZF_DEFAULT_COMMAND="fd -c always -d 5 -td -tf -j$(nproc) --no-require-git '.*'"
    P=$(fzf --tmux 80% --algo=v1 --ansi --tiebreak=length --tail 100000)
	if [ -d $P ]; then 
		pushd $P 2>/dev/null
	elif [ -r $P ]; then
		$VISUAL $P
	fi	
	export FZF_DEFAULT_COMMAND="$FZF_OLD_DEFAULT_COMMAND"
}


#ripgrep->fzf->vim [QUERY]
frg() {
  local T="$(mktemp)"
  trap "rm -f ${T}; trap - EXIT INT" EXIT INT
  local R="reload:rg -j$(nproc) --color=always --smart-case {q} "
  [ ! -t 0 ] && R+="-N ${T}" || R+='--column'
  local C=(--disabled --ansi --multi --tmux 85%
		--bind 'alt-a:select-all,alt-d:deselect-all'
 		--bind "start:${R} || :" 
		--bind "change:${R} || :"
		--delimiter : --query "$*")
  if [ ! -t 0 ]; then # if pipe then
    cat > "${T}"
    fzf "${C[@]}" --bind "enter:become:echo {3..}"
  else
    fzf "${C[@]}" --with-nth=1,2 --bind \
	    'enter:become:[ $FZF_SELECT_COUNT -eq 0 ] && vim {1} +{2} || vim +cw -q {+f}'\
	--preview 'bat --style=full --color=always --highlight-line {2} {1}'\
	--preview-window "~4,+{2}+4/3,<80(right)"
  fi
}

fld() {
  [ -t 0 ] && echo Input must be from stdin && return -1
  local T="$(mktemp)"
  trap "rm -f ${T}; trap - EXIT INT" EXIT INT
  cat > "${T}"
  local C="cat ${T}"
  local R="reload:awk \"{q=\\\"{q}\\\";gsub(/'/,\\\"\\\",q);n=split(q,a);for(i=1;i<=n;i++)printf(\\\"%s \\\",\\\$a[i]);printf(\\\"\\\\n\\\")}\" ${T} || :"

  fzf --disabled --multi \
	--bind "start:reload:${C}"  \
	--bind "change:${R}" \
	--bind "enter:select-all+accept" \
        --preview "${C}"
}

