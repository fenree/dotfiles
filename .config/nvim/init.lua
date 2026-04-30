-- THE BASICS --
local vo = vim.opt
vo.autoindent     = true
vo.autoread       = true
vo.clipboard      = 'unnamedplus'
vo.conceallevel   = 2
vo.concealcursor  = 'n'
vo.diffopt        = "internal,filler,closeoff,indent-heuristic,inline:char,linematch:40,vertical"
vo.foldmethod     = 'expr'
vo.foldexpr       = 'nvim_treesitter#foldexpr()'
vo.foldenable     = false
vo.formatoptions  = cnm
vo.swapfile       = false
vo.relativenumber = true
vo.number         = true
vo.shiftwidth     = 4
vo.softtabstop    = 4
vo.tabstop        = 4
vo.winborder      = "rounded"

-- PLUGINS --
vim.pack.add({
	 "https://github.com/catppuccin/nvim",
	 "https://github.com/christoomey/vim-tmux-navigator",
	 "https://github.com/nvim-treesitter/nvim-treesitter" ,
})

-- COLORSCHEME --
local c = vim.cmd
local va = vim.api
local hl = va.nvim_set_hl
c.colorscheme("catppuccin")
hl(0, "LineNrAbove", { fg = "#89dceb" })
hl(0, "LineNrBelow", { fg = "#89dceb" })
hl(0, "LineNr", { fg = "#fab387" })
hl(0, "NormalFloat", { bg = "none" })
hl(0, "StatusLine", { bg = "none" })

-- HELPERS --
require 'nvim-treesitter.config'.setup {
	highlight = { 
		enable = true,
		additional_vim_regex_highlighting = false, 
    		max_file_length = 10000,
	},
	indent = { enable = true, },
}

vim.g.markdown_fenced_languages = {'python', 'cpp', 'c', 'bash', 'awk'}

local vtl = vim.treesitter.language.register
vtl('markdown_inline', 'md')
vtl('python', 'py')
vtl('json', 'json')


-- KEYS --
local m = va.nvim_set_keymap
local function nm(x, y) m('n', x, y, {silent = true, noremap = true}) end
local function im(x, y) m('i', x, y, {silent = true, noremap = true}) end
local function vm(x, y) m('v', x, y, {silent = true, noremap = true}) end
local function nmr(x, y) m('n', x, y, {silent = true}) end
local function imr(x, y) m('i', x, y, {silent = true}) end
local function vmr(x, y) m('v', x, y, {silent = true}) end

vim.g.mapleader = " "
nm('<leader>rc', ':lua vim.cmd("edit " .. vim.fn.system("~/tools/edrc"):gsub("%s+$", ""))<CR>') 

-- buffers / panes
nm('<leader>bk',':bd<CR>')
nm('<leader>bd',':bd<CR>')
nm('<leader>bp',':bp<CR>')
nm('<leader>bn',':bn<CR>')
nm('<Tab>',':bn<CR>')
nm('<S-Tab>',':bp<CR>')
nm('-',':vs<CR>')
nm('_',':sp<CR>')

nm('<C-h>',':TmuxNavigateLeft<CR>')
nm('<C-l>',':TmuxNavigateRight<CR>')
nm('<C-k>',':TmuxNavigateUp<CR>')
nm('<C-j>',':TmuxNavigateDown<CR>')
nm('<ESC>',':nohlsearch<CR>')

-- AUTOCOMMANDS --
local a = va.nvim_create_autocmd
a({'BufEnter', 'BufWinEnter'}, {
  pattern = '*.md',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end
})

