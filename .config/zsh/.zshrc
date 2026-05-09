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
