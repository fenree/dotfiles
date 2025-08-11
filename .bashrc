[[ $- != *i* ]] && return

if [[ -r /usr/share/bash-completion/bash_completion ]]; then
  . /usr/share/bash-completion/bash_completion
fi

eval $(dircolors ~/.dircolors)

case $- in
    *i*) ;;
      *) return;;
esac

shopt -s checkwinsize
shopt -s globstar
shopt -s histappend

. ~/.config/.bash_aliases
. ~/.config/.bash_git

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
HISTIGNORE="ls:ll:cd:pwd:clear"
PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " %s")'; PS1='\[\e[38;5;114;1m\]\u\[\e[0m\] \[\e[38;5;114;1m\]󰄛\[\e[0m\]  \[\e[38;5;111;1m\]\h\[\e[0m\] \[\e[38;5;202;1m\]${PS1_CMD1}\n\[\e[0;38;5;225m\]\w\[\e[0m\] \$ '

if [ ! -d "$HOME/.cfg" ]; then
	git init --bare $HOME/.cfg
	/usr/bin/git --git-dir="$HOME/.cfg" --work-tree="$HOME" config --local status.showUntrackedFiles no
fi
