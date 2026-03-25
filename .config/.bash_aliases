command -v doas >/dev/null && sudo=doas || sudo=sudo

alias in='yay -S'
alias un='yay -Rdd'
alias upd='yay -Syu'
alias ss='yay -Ss'
alias mci="make clean && make -j20 -l5 && ${sudo} make install"
alias idf='source /home/zephyr/src/esp-idf/export.sh'
alias prm='$sudo chmod +x'
alias lp='pacman -Qqe'

alias cmdv=">/dev/null command -v"
cmdv bat && . /dev/stdin <<'EOF'
	alias cat='bat'
	cmdv rg && alias bg='batgrep'
EOF

alias fdpid="ps a --noheaders | dmenu | awk '{print $1}'"

alias cfg='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'




alias config='/usr/bin/git --git-dir=/home/zephyr/.cfg/ --work-tree=/home/zephyr'
