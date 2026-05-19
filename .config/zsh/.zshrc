[ -r ~/.dircolors ] || dircolors -p > ~/.dircolors
eval $(dircolors -b ~/.dircolors 2>/dev/null)

unsetopt autocd beep notify
setopt extendedglob nomatch
setopt appendhistory
setopt sharehistory
setopt histignoredups
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
autoload -U compinit; compinit
autoload -Uz vcs_info
setopt AUTO_LIST
setopt COMPLETE_IN_WORD
setopt AUTO_PARAM_SLASH
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands
zstyle ':completion:*' verbose yes
zstyle ":completion:*:*:${EDITOR##/*/}:*" file-sort change
zstyle ':completion:*' use-cache on
zstyle ':completion:*' menu select
zstyle ':completion:*' cache-path "${ZDOTDIR}/zsh/.zcompcache"
# make this formatting look better at some point probably
zstyle ':completion:*' group-name '' # group results so all descriptions arent at the top
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# colors :D
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

source "${ZDOTDIR}/.aliases.zsh"
source "${ZDOTDIR}/.functions.zsh"
source "/usr/share/fzf/completion.zsh"
source "/usr/share/fzf/key-bindings.zsh"
setopt PROMPT_SUBST

zstyle ':vcs_info:git:*' enable git
zstyle ':vcs_info:git:*' formats ' %b%u%c'
zstyle ':vcs_info:git:*' actionformats ' %b|%a'
zstyle ':vcs_info:git:*' check-for-changes yes
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' stagedstr '+'

preexec() { 
	# this should be last in preexec
	e=$SECONDS 
}

precmd() {
	# error code first
	_err=$(printf "%03d" $?)	
	# time elapsed should be captured after
	e=$(( SECONDS - e ))
	
	## globals to be used in prompt
	_git_ps1=""
	_time=""
	_d="${PWD/#$HOME/~}"

	## handle error code formatting
    # if leading zero then space
    [[ $_err =~ ^0(..) ]] && _err=" ${match[1]}"
    # if middle zero then space (intentionally only triggers
    # when the first regex succeeded as we'd otherwise ruin a number
    [[ $_err =~ ^\ 0(.) ]] && _err=" ${match[1]} "
	
	## git 	
	local _u=""
	local _s=""
	if git rev-parse --git-dir &>/dev/null; then
		vcs_info
		git rev-parse --verify -q refs/stash &>/dev/null && _s='$'
		local c=$(git rev-list --count --left-right @{_u}...HEAD 2>/dev/null)
		(( ${c%$'\t'*} )) && _u+="<${c%$'\t'*}"
		(( ${c#*$'\t'} )) && _u+=">${c#*$'\t'}"
		_git_ps1="${vcs_info_msg_0_}${_s}${_u}"
	fi
	
	## time
	(( e >= 60 )) && _time=$(printf "%02d:%02d:%02d" $(( e/3600 )) $(( e%3600/60 )) $(( e%60 )))
	
	## current directory
	local p=(${(s:/:)_d})
	local i=$(( ${#PWD} != ${#_d} ))
	(( ${#p} > 4 + i )) && _d="${(j:/:)p[1,2+i]}/*/${(j:/:)p[-2,-1]}"
}

PS1=$'%{\e[0;38;5;225m%} ${_d}%{\e[0m%}%{\e[38;5;111;1m%} ${_time}%{\e[0m%}%{\e[38;5;202;1m%}${_git_ps1}\n%{\e[0m%} %(?.   .%{\e[1;38;2;235;160;172m%}${_err}%{\e[0m%}) %# '
