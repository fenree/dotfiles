# Hist
export HISTFILE="${ZDOTDIR}/.zhistory"
export HISTSIZE=2000
export SAVEHIST=2000

# Text based tooling
export VISUAL=/bin/nvim
export EDITOR=$VISUAL
export PAGER=less
export BAT_PAGER=less
export MANPAGER='zsh -c "col -bx | bat -lman --style=changes"'
export LESS='-RF'
export GROFF_NO_SGR=
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export FZF_DEFAULT_COMMAND="fd -c always -td -tf --no-require-git '.*'"
export FZF_DEFAULT_OPTS="--algo=v1 --ansi --tiebreak=length --tail 100000"
