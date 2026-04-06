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

jd() {
    
(RELOAD='reload:rg --column --color=always --smart-case {q} || :'
 fzf --disabled --ansi \
     --bind "start:$RELOAD" --bind "change:$RELOAD" \
     --bind 'enter:become:vim {1} +{2}' \
     --delimiter : \
     --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
     --preview-window '~4,+{2}+4/3,<80(right)')
}

	#ripgrep->fzf->vim [QUERY]
frg() (
  RELOAD='reload:rg'" -j$(nproc) "'--column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            vim {1} +{2}     # No selection. Open the current line in Vim.
          else
            vim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --with-nth=1,2 \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(right)' \
      --query "$*"
)

