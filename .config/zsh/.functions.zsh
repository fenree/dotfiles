alias fdrc='for f in ~/{.*{.,git}conf*,.*rc*,.config/*/{*conf*,*.ini,*init*,*lua*,.*zsh*}}; do echo ${f##~/}; done'
alias edrc='fdrc | fzf --bind "enter:become:'$EDITOR' ~/{1}" --preview "bat --style=full --color always ~/{}"'
for a in ecd ecr erc ecr ecrd erdc edcr derc decr; do alias $a=edrc; done

cursor_mode() {
    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursors
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}

cursor_mode
