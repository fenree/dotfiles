#!/bin/sh
CWD=$(pwd)
if [ -d "${1}" ]; then
	cd "${1}" 
fi

R="reload:rg -j$(nproc) --color=always --smart-case --column {q} "
set -- --disabled --ansi --tmux 85% \
       --bind "start:${R} || :" \
       --bind "change:${R} || :" \
       --delimiter :
  fzf "$@" --with-nth=1,2 --bind \
	  "enter:become:echo \"edit +call\ cursor({2},{3}) ${CWD}/{1} \"| tr -d \\'" \
  --bind "ctrl-b:become:git blame {1} | awk 'NR=='{2}'{print \$1;exit}'" \
  --bind "ctrl-g:transform:[ \"\$FZF_PREVIEW_LABEL\" = 'blame' ] \
&& echo 'change-preview-label(bat)+change-preview(bat --style=full --color=always --highlight-line {2} {1})' \
|| echo 'change-preview-label(blame)+change-preview(git blame -L {2},+10 {1})'" \
  --preview-label 'bat' \
  --preview 'bat --style=full --color=always --highlight-line {2} {1}'\
  --preview-window "~4,+{2}+4/3,<80(right)"
