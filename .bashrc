[[ $- != *i* ]] && return

eval $(dircolors ~/.dircolors 2>/dev/null)

export VISUAL=/bin/nvim
export EDITOR=$VISUAL


for opt in     \
    direxpand  \
    dirspell   \
    extglob    \
    globstar   \
    histappend 
do 
    shopt -s $opt 
done

for script in \
    /usr/share/bash-completion/bash_completion* \
    ~/.config/{.bash*,nnn/.nnnrc}
do
    . $script 2>/dev/null
done

bind 'set mark-directories on'

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
HISTIGNORE="lh:ll:cd:pwd:clear"
PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " %s")' 
PS1='\[\e[38;5;114;1m\]\u\[\e[0m\] \[\e[38;5;114;1m\]󰄛\[\e[0m\]  \[\e[38;5;111;1m\]\h\[\e[0m\] \[\e[38;5;202;1m\]${PS1_CMD1}\n\[\e[0;38;5;225m\]\w\[\e[0m\] \$ '

export NNN_COLORS="#04020301;4231"
export NNN_FCOLORS="030304020705050801060301"
export RIPGREP_CONFIG_PATH="$HOME/.rgrc"

if [ ! -d "$HOME/dotfiles" ]; then
	git init --bare $HOME/dotfiles
	/usr/bin/git --git-dir="$HOME/dotfiles" --work-tree="$HOME" config --local status.showUntrackedFiles no
fi

alias cfg="git --git-dir=$HOME/.cfg --work-tree=$HOME"

bind -r \C-p
bind -r \C-n

