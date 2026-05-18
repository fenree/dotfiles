# GNUtils
alias cat=bat
alias grep=rg

# navigation
alias cwd='cd $(git rev-parse --show-toplevel)'
alias crd='cd $(git rev-parse --show-toplevel)'

# ls
alias lh='ls --color=auto -plh'
alias ls='ls --color=auto -p'

# make
alias mci='make clean && make && sudo make install'

# zsh
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

alias zali="${EDITOR} ${ZDOTDIR}/.aliases.zsh"
alias zfun="${EDITOR} ${ZDOTDIR}/.functions.zsh"
alias zenv="${EDITOR} ${ZDOTDIR}/.zshenv"
alias zrc="source ${ZDOTDIR}/.zshrc"

