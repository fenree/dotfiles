which doas > /dev/null && sudo=doas || sudo=sudo

alias in='yay -S'
alias un='yay -Rdd'
alias upd='yay -Syu'
alias ss='yay -Ss'
alias mci='make clean && make -j20 -l5 && $sudo make install'
alias idf='source /home/zephyr/src/esp-idf/export.sh'
alias prm='$sudo chmod +x'
alias lp='pacman -Qqe'

alias fdpid="ps a --noheaders | dmenu | awk '{print $1}'"

alias cfg='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'

#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#    alias ls='ls --color=auto'
#    alias dir='dir --color=auto'
#    alias vdir='vdir --color=auto'
#
#    alias grep='grep --color=auto'
#    alias fgrep='fgrep --color=auto'
#    alias egrep='egrep --color=auto'
#fi

alias ls='ls --color=auto'
#alias grep=''

alias config='/usr/bin/git --git-dir=/home/zephyr/.cfg/ --work-tree=/home/zephyr'
