mkcd() {
    mkdir -p $@ && cd ${!#}
}

j() {
	export FZF_DEFAULT_COMMAND="fd -c always -d 5 -td -tf --no-require-git '.*'"
    P=$(fzf-tmux --algo=v1 --ansi --tiebreak=length --tail 100000)
	if [ -d $P ]; then 
		pushd $P 2>/dev/null
	elif [ -r $P ]; then
		$VISUAL $P
	fi	
}
jd() {
    
(RELOAD='reload:rg --column --color=always --smart-case {q} || :'
 fzf --disabled --ansi \
     --bind "start:$RELOAD" --bind "change:$RELOAD" \
     --bind 'enter:become:vim {1} +{2}' \
     --delimiter : \
     --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
     --preview-window '~4,+{2}+4/3,<80(up)')
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
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
)
}

