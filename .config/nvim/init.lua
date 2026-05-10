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

local va = vim.api
local hl = va.nvim_set_hl
hl(0, "LineNrAbove", { fg = "#89dceb" })
hl(0, "LineNrBelow", { fg = "#89dceb" })
hl(0, "LineNr", { fg = "#fab387" })
hl(0, "NormalFloat", { bg = "none" })
hl(0, "StatusLine", { bg = "none" })


-- PLUGINS --
local gh = "https://github.com/"
vim.pack.add({
	 gh .. "catppuccin/nvim",
	 gh .. "christoomey/vim-tmux-navigator",
	 gh .. "nvim-treesitter/nvim-treesitter" ,
})

-- COLORSCHEME --
local c = vim.cmd
c.colorscheme("catppuccin")

-- HELPERS --
require 'nvim-treesitter.config'.setup {
	ensure_installed = { 'awk',
						 'bash', 
						 'bitbake',
						 'c',
						 'cmake',
						 'comment',
						 'cpp',
						 'csv',
						 'devicetree',
						 'diff',
						 'disassembly',
						 'dockerfile',
						 'doxygen',
						 'git_config',
						 'git_rebase',
						 'gitattributes',
						 'gitcommit',
						 'gitignore',
						 'ini',
						 'json',
						 'jq',
						 'kconfig',
						 'latex',
						 'linkerscript',
						 'lua',
						 'make',
						 'markdown',
						 'markdown_inline',
						 'python',
						 'readline',
						 'regex',
						 'requirements', --pip
						 'strace', -- .strace files
						 'sshconfig', 
						 'tmux',
						 'toml',
						 'typst',
						 'udev',
						 'vim',
						 'vimdoc',
						 'xml',
						 'yaml',
						 'zathurarc',
						 'zsh', 
					 },
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
local function nm(x, y, r) m('n', x, y, {silent = true, noremap = not r}) end
local function im(x, y, r) m('i', x, y, {silent = true, noremap = not r}) end
local function vm(x, y, r) m('v', x, y, {silent = true, noremap = not r}) end
vim.g.mapleader = " "
nm('<leader>rc', ':lua vim.cmd("e " .. vim.fn.system("$HOME/tools/edrc"))<CR>') 

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

