mkcd() {
    mkdir -p $@ && cd ${!#}
}

fdrc() {	

    pushd "$HOME" >/dev/null
    fd -c always -d 1 -sH -tf -j$(nproc) '^\..*(rc|\.conf)' -E '*.backup' -E '*.tmp'
    fd -c always -d 2 -sH -tf -j$(nproc) '\.(rc|conf|vim|lua)$' -E '*.backup' -E '*.tmp' '.config/'
    popd >/dev/null
}

edrc() {
	vim $(fdrc | fzf --tmux --algo=v1 --ansi --tiebreak=length --tail 100000)
}


j() {
	local FZF_OLD_DEFAULT_COMMAND="$FZF_DEFAULT_COMMAND"
	export FZF_DEFAULT_COMMAND="fd -c always -d 5 -td -tf -j$(nproc) --no-require-git '.*'"
    P=$(fzf --tmux --algo=v1 --ansi --tiebreak=length --tail 100000)
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
     --preview-window '~4,+{2}+4/3,<80(up)')
}

	#ripgrep->fzf->vim [QUERY]
frg() (
  RELOAD='reload:rg'" -j$(nproc) "'--column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            nvim {1} +{2}     # No selection. Open the current line in Vim.
          else
            nvim +cw -q {+f}  # Build quickfix list for the selected items.
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

