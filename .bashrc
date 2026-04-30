[[ $- != *i* ]] && return

[ -r ~/.dircolors ] || dircolors -p > ~/.dircolors
eval $(dircolors -b ~/.dircolors 2>/dev/null)

export VISUAL=/bin/nvim
export EDITOR=$VISUAL
export PAGER=less
export BAT_PAGER=less
export MANPAGER='bash -c "col -bx | bat -lman --style=changes"'
export LESS='-RF'
export GROFF_NO_SGR=

alias printescapes='for i in $(seq 30 37); do echo -e "\E[${i}m color $i \E[0m"; done'
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

for opt in     \
	cdable_vars \
    direxpand  \
    dirspell   \
    extglob    \
    globstar   \
    histappend 
do 
    shopt -s $opt 
done

for script in \
	/usr/share/fzf/*.bash \
    /usr/share/bash-completion/completions/* \
    ~/.config/.bash*
do
    . $script 2>/dev/null
done


export FZF_DEFAULT_COMMAND="fd -c always -td -tf --no-require-git '.*'"
export FZF_DEFAULT_OPTS="--tmux 80% --algo=v1 --ansi --tiebreak=length --tail 100000"

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
HISTIGNORE="lh:ll:cd:pwd:clear"
PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " %s")' 
PS1='\[\e[38;5;114;1m\]\u\[\e[0m\] \[\e[38;5;114;1m\]󰄛\[\e[0m\]  \[\e[38;5;111;1m\]\h\[\e[0m\] \[\e[38;5;202;1m\]${PS1_CMD1}\n\[\e[0;38;5;225m\]\w\[\e[0m\] \$ '

export RIPGREP_CONFIG_PATH="$HOME/.rgrc"

GITDIR="${HOME}/.config/.git"
alias cfg="git --git-dir=${GITDIR} --work-tree=${HOME}"
if [ ! -d "${GITDIR}" ]; then
	git init --bare "${GITDIR}"
	echo "${GITDIR}" >> "${GITDIR}/info/exclude"
	cfg remote add origin https://github.com/fenree/dotfiles
	cfg fetch origin
	cfg config --local status.showUntrackedFiles no
fi
