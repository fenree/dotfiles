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
	 gh .. 'neovim/nvim-lspconfig',
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
---------
-- LSP --
---------

local lse = vim.lsp.enable
local lsc = vim.lsp.config
local lsb = vim.lsp.buf
lsc('clangd', {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=iwyu',
    '--completion-style=detailed',
    '--function-arg-placeholders=true',
  },
  filetypes = { 'c', 'cpp' },
  root_markers = { '.clangd', 'compile_commands.json', '.git' },
  capabilities = { offsetEncoding = { 'utf-16' }, },
})
lse('clangd')
lsc('luals', {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc' },
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT'
			},
		}
	}
})
lse('luals')

lse('pyright')


-- KEYS --

local m = va.nvim_set_keymap
local function nm(x, y, r) m('n', x, y, {silent = true, noremap = not r}) end
local function im(x, y, r) m('i', x, y, {silent = true, noremap = not r}) end
local function vm(x, y, r) m('v', x, y, {silent = true, noremap = not r}) end
local function bnm(x, y, r, b) vim.keymap.set('n', x, y, {buffer = b, silent = true, noremap = not r}) end
local function bim(x, y, r, b) vim.keymap.set('i', x, y, {buffer = b, silent = true, noremap = not r}) end
local function bvm(x, y, r, b) vim.keymap.set('v', x, y, {buffer = b, silent = true, noremap = not r}) end

vim.g.mapleader = " "
nm('<leader>rc', ':lua vim.cmd("e " .. vim.fn.system("$HOME/tools/edrc"))<CR>')
nm('<leader>frg', ':lua vim.cmd(vim.fn.system("$HOME/tools/frg.sh"))<CR>')

-- make
nm('<leader>mm',':make<CR>')
nm('<leader>mc',':make clean<CR>')
nm('<leader>mr',':make run<CR>')

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

nm('<leader>ln', 
	':lua vim.o.relativenumber = not vim.o.relativenumber<CR>'
	.. ':lua vim.o.number = not vim.o.number<CR>')
nm('<leader>lN', ':lua vim.o.number = not vim.o.number<CR>')

vm('<leader>a', ':!awk \'\'<Left>')
vm('<leader>n', ':norm ')
-- why did i make this
--vm('<leader>i', ':s/\\(.$\\)/\\1<Left><Left>')
--vm('<leader>a', ':s/\\(^.\\)/\\1<Left><Left>')

nm('<Tab>', '<Esc>/[)\\}"\'>]<CR><ESC>a', true)
nm('<S-Tab>', '<Esc>?[([{"\'<]<CR><ESC>a', true)


-- AUTOCOMMANDS --
local a = va.nvim_create_autocmd
local vfs = vim.fs
local vfn = vim.fn
local root_markers = { '.git', '.clangd', 'Makefile'}
-- possibly useful dunno
a("BufEnter", {
	callback = function()
		local r = vfs.find(root_markers, { upward = true })[1]
		if r then
			vfn.chdir(vfs.dirname(r))
		end
	end
})


a({'BufEnter', 'BufWinEnter'}, {
  pattern = '*.md',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end
})

a('LspAttach', {
	pattern = { '*' },
	callback = function(event)
		bnm('gd',        ':lua vim.lsp.buf.definition()<CR>', false, event.buf)
		bnm('gr',        ':lua vim.lsp.buf.references()<CR>', false, event.buf)
		nm('gI',         ':lua vim.lsp.buf.implementation()<CR>')
		nm('<leader>D',  ':lua vim.lsp.buf.type_definition()<CR>')
		nm('<leader>rn', ':lua vim.lsp.buf.rename()<CR>')
		nm('<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
		nm('C-K',':lua vim.lsp.buf.hover()<CR>')
	end })

a({ "BufRead", "BufNewFile" }, {
  pattern = "*.inc",
  callback = function()
    vim.bo.filetype = "bitbake"
  end,
})
