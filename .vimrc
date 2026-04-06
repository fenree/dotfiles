vim9script
# need -ne to avoid newline and to add backslash escape interpretation
silent !echo -ne "\e[2 q" 
## term settings
&t_EI = "\e[2 q"
&t_SI = "\e[6 q"
&t_SR = "\e[4 q"
set autoindent
set autoread
set clipboard=unnamedplus
set conceallevel=2
set concealcursor=n
set diffopt=internal,filler,closeoff,indent-heuristic,inline:char,linematch:40,vertical
set formatoptions=cnm
set noswapfile
set shiftwidth=4
set softtabstop=4
set tabstop=4
set t_Co=256
set ttimeout
set ttimeoutlen=10
set termguicolors
set number
set rnu
set cscopetag
set csto=0
g:mapleader = ' '
call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

nnoremap <leader>rc :let f=trim(system('~/tools/edrc'))<CR>:if f != '' \| execute 'e' f \| endif<CR><CR>

# Optional: open results in the quickfix window automatically

autocmd QuickFixCmdPost cscope silent! copen
if filereadable("cscope.out")
  silent! cs kill -1
  silent! cs add cscope.out
endif
nnoremap <leader>cfi :cs find i 
nnoremap <leader>cft :cs find i 
nnoremap <silent> <leader>cc :cs find c <C-R>=expand('<cword>')<CR><CR>

g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :<C-U>TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :<C-U>TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :<C-U>TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :<C-U>TmuxNavigateRight<cr>
nnoremap <silent> <c--> :<C-U>TmuxNavigatePrevious<cr>


syntax on
hi Normal guisp=NONE guifg=#CDD6F4 guibg=#1E1E2E gui=NONE cterm=NONE 
hi Visual guisp=NONE guifg=NONE guibg=#45475A gui=bold cterm=bold 
hi Conceal guisp=NONE guifg=#7F849C guibg=NONE gui=NONE cterm=NONE 
hi ColorColumn guisp=NONE guifg=NONE guibg=#313244 gui=NONE cterm=NONE 
hi Cursor guisp=NONE guifg=#1E1E2E guibg=#F5E0DC gui=NONE cterm=NONE 
hi lCursor guisp=NONE guifg=#1E1E2E guibg=#F5E0DC gui=NONE cterm=NONE
hi CursorIM guisp=NONE guifg=#1E1E2E guibg=#F5E0DC gui=NONE cterm=NONE
hi CursorColumn guisp=NONE guifg=NONE guibg=#181825 gui=NONE cterm=NONE
hi CursorLine guisp=NONE guifg=NONE guibg=#313244 gui=NONE cterm=NONE
hi Directory guisp=NONE guifg=#89B4FA guibg=NONE gui=NONE cterm=NONE
hi DiffAdd guisp=NONE guifg=#1E1E2E guibg=#A6E3A1 gui=NONE cterm=NONE
hi DiffChange guisp=NONE guifg=#1E1E2E guibg=#F9E2AF gui=NONE cterm=NONE
hi DiffDelete guisp=NONE guifg=#1E1E2E guibg=#F38BA8 gui=NONE cterm=NONE
hi DiffText guisp=NONE guifg=#1E1E2E guibg=#89B4FA gui=NONE cterm=NONE
hi EndOfBuffer guisp=NONE guifg=NONE guibg=NONE gui=NONE cterm=NONE
hi ErrorMsg guisp=NONE guifg=#F38BA8 guibg=NONE gui=bold,italic cterm=bold,italic
hi VertSplit guisp=NONE guifg=#11111B guibg=NONE gui=NONE cterm=NONE
hi Folded guisp=NONE guifg=#89B4FA guibg=#45475A gui=NONE cterm=NONE
hi FoldColumn guisp=NONE guifg=#6C7086 guibg=#1E1E2E gui=NONE cterm=NONE
hi SignColumn guisp=NONE guifg=#45475A guibg=#1E1E2E gui=NONE cterm=NONE
hi IncSearch guisp=NONE guifg=#45475A guibg=#F5C2E7 gui=NONE cterm=NONE
hi CursorLineNR guisp=NONE guifg=#B4BEFE guibg=NONE gui=NONE cterm=NONE
hi LineNr guisp=NONE guifg=#45475A guibg=NONE gui=NONE cterm=NONE
hi MatchParen guisp=NONE guifg=#FAB387 guibg=NONE gui=bold cterm=bold
hi ModeMsg guisp=NONE guifg=#CDD6F4 guibg=NONE gui=bold cterm=bold
hi MoreMsg guisp=NONE guifg=#89B4FA guibg=NONE gui=NONE cterm=NONE
hi NonText guisp=NONE guifg=#6C7086 guibg=NONE gui=NONE cterm=NONE
hi Pmenu guisp=NONE guifg=#9399B2 guibg=#313244 gui=NONE cterm=NONE
hi PmenuSel guisp=NONE guifg=#CDD6F4 guibg=#45475A gui=bold cterm=bold
hi PmenuSbar guisp=NONE guifg=NONE guibg=#45475A gui=NONE cterm=NONE
hi PmenuThumb guisp=NONE guifg=NONE guibg=#6C7086 gui=NONE cterm=NONE
hi Question guisp=NONE guifg=#89B4FA guibg=NONE gui=NONE cterm=NONE
hi QuickFixLine guisp=NONE guifg=NONE guibg=#45475A gui=bold cterm=bold
hi Search guisp=NONE guifg=#F5C2E7 guibg=#45475A gui=bold cterm=bold
hi SpecialKey guisp=NONE guifg=#A6ADC8 guibg=NONE gui=NONE cterm=NONE
hi SpellBad guisp=NONE guifg=#1E1E2E guibg=#F38BA8 gui=NONE cterm=NONE
hi SpellCap guisp=NONE guifg=#1E1E2E guibg=#F9E2AF gui=NONE cterm=NONE
hi SpellLocal guisp=NONE guifg=#1E1E2E guibg=#89B4FA gui=NONE cterm=NONE
hi SpellRare guisp=NONE guifg=#1E1E2E guibg=#A6E3A1 gui=NONE cterm=NONE
hi StatusLine guisp=NONE guifg=#CDD6F4 guibg=#181825 gui=NONE cterm=NONE
hi StatusLineNC guisp=NONE guifg=#45475A guibg=#181825 gui=NONE cterm=NONE
hi StatusLineTerm guisp=NONE guifg=#CDD6F4 guibg=#181825 gui=NONE cterm=NONE
hi StatusLineTermNC guisp=NONE guifg=#45475A guibg=#181825 gui=NONE cterm=NONE
hi TabLine guisp=NONE guifg=#45475A guibg=#181825 gui=NONE cterm=NONE
hi TabLineFill guisp=NONE guifg=NONE guibg=#181825 gui=NONE cterm=NONE
hi TabLineSel guisp=NONE guifg=#A6E3A1 guibg=#45475A gui=NONE cterm=NONE
hi Title guisp=NONE guifg=#89B4FA guibg=NONE gui=bold cterm=bold
hi VisualNOS guisp=NONE guifg=NONE guibg=#45475A gui=bold cterm=bold
hi WarningMsg guisp=NONE guifg=#F9E2AF guibg=NONE gui=NONE cterm=NONE
hi WildMenu guisp=NONE guifg=NONE guibg=#6C7086 gui=NONE cterm=NONE
hi Comment guisp=NONE guifg=#6C7086 guibg=NONE gui=NONE cterm=NONE
hi Constant guisp=NONE guifg=#FAB387 guibg=NONE gui=NONE cterm=NONE
hi Identifier guisp=NONE guifg=#F2CDCD guibg=NONE gui=NONE cterm=NONE
hi Statement guisp=NONE guifg=#CBA6F7 guibg=NONE gui=NONE cterm=NONE
hi PreProc guisp=NONE guifg=#F5C2E7 guibg=NONE gui=NONE cterm=NONE
hi Type guisp=NONE guifg=#89B4FA guibg=NONE gui=NONE cterm=NONE
hi Special guisp=NONE guifg=#F5C2E7 guibg=NONE gui=NONE cterm=NONE
hi Underlined guisp=NONE guifg=#CDD6F4 guibg=#1E1E2E gui=underline cterm=underline
hi Error guisp=NONE guifg=#F38BA8 guibg=NONE gui=NONE cterm=NONE
hi Todo guisp=NONE guifg=#1E1E2E guibg=#F2CDCD gui=bold cterm=bold
hi String guisp=NONE guifg=#A6E3A1 guibg=NONE gui=NONE cterm=NONE
hi Character guisp=NONE guifg=#94E2D5 guibg=NONE gui=NONE cterm=NONE
hi Number guisp=NONE guifg=#FAB387 guibg=NONE gui=NONE cterm=NONE
hi Boolean guisp=NONE guifg=#FAB387 guibg=NONE gui=NONE cterm=NONE
hi Float guisp=NONE guifg=#FAB387 guibg=NONE gui=NONE cterm=NONE
hi Function guisp=NONE guifg=#89B4FA guibg=NONE gui=NONE cterm=NONE
hi Conditional guisp=NONE guifg=#F38BA8 guibg=NONE gui=NONE cterm=NONE
hi Repeat guisp=NONE guifg=#F38BA8 guibg=NONE gui=NONE cterm=NONE
hi Label guisp=NONE guifg=#FAB387 guibg=NONE gui=NONE cterm=NONE
hi Operator guisp=NONE guifg=#89DCEB guibg=NONE gui=NONE cterm=NONE
hi Keyword guisp=NONE guifg=#F5C2E7 guibg=NONE gui=NONE cterm=NONE
hi Include guisp=NONE guifg=#F5C2E7 guibg=NONE gui=NONE cterm=NONE
hi StorageClass guisp=NONE guifg=#F9E2AF guibg=NONE gui=NONE cterm=NONE
hi Structure guisp=NONE guifg=#F9E2AF guibg=NONE gui=NONE cterm=NONE
hi Typedef guisp=NONE guifg=#F9E2AF guibg=NONE gui=NONE cterm=NONE
hi debugPC guisp=NONE guifg=NONE guibg=#11111B gui=NONE cterm=NONE
hi debugBreakpoint guisp=NONE guifg=#6C7086 guibg=#1E1E2E gui=NONE cterm=NONE
hi link Define PreProc

hi link Macro PreProc
hi link PreCondit PreProc
hi link SpecialChar Special
hi link Tag Special
hi link Delimiter Special
hi link SpecialComment Special
hi link Debug Special
hi link Exception Error
hi link StatusLineTerm StatusLine
hi link StatusLineTermNC StatusLineNC
hi link Terminal Normal
hi link Ignore Comment

g:terminal_ansi_colors = [
  \ "#45475A", "#F38BA8", "#A6E3A1", "#F9E2AF", "#89B4FA", "#F5C2E7", "#94E2D5", "#BAC2DE",
  \ "#585B70", "#F38BA8", "#A6E3A1", "#F9E2AF", "#89B4FA", "#F5C2E7", "#94E2D5", "#A6ADC8"
\ ]

