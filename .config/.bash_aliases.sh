alias cmdv=">/dev/null command -v"
cmdv doas && sudo=doas || sudo=sudo

alias in='yay -S'
alias un='yay -Rdd'
alias upd='yay -Syu'
alias ss='yay -Ss'

# echo is faster than printf when we dont need format strings and it is always built into bash
alias fdrc='(shopt -s extglob; for f in ~/{?(.)?(*conf?(ig)|*rc|dircolors),.config/*/?(*conf*|*init*|*rc)}; do echo ${f##~/}; done)'

alias edrc='fdrc | fzf --bind "enter:become:[[ \$FZF_SELECT_COUNT -eq 0 ]] && nvim {1} +{2} || nvim +cw -q {+f}" --preview "bat --style=full --color always {}"'
alias edc='edrc'
alias mci="make clean && make -j$(nproc) -l5 && ${sudo} make install"
alias idf='source /home/zephyr/src/esp-idf/export.sh'
alias prm='$sudo chmod +x'
alias lp='pacman -Qqe'


alias bali="$EDITOR $HOME/.config/.bash_aliases.sh"
alias bfun="$EDITOR $HOME/.config/.bash_functions.sh"


cmdv bat && . /dev/stdin <<'EOF'
	alias cat='bat'
	cmdv rg && alias bg='batgrep'
EOF



alias fdpid="ps a --noheaders | dmenu | awk '{print $1}'"

alias cfg='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'

alias ls='ls --color=always'
alias lh='ls -gho'


alias config='/usr/bin/git --git-dir=/home/zephyr/.cfg/ --work-tree=/home/zephyr'
