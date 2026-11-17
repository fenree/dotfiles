-- THE BASICS --
local vg = vim.g
local vo = vim.opt

vg.editorconfig   = true
vo.autoindent     = true
vo.autoread       = true
vo.termguicolors  = false
vo.clipboard      = 'unnamedplus'
vo.conceallevel   = 2
vo.concealcursor  = 'n'
vo.diffopt        = "internal,filler,closeoff,indent-heuristic,inline:char,linematch:40,vertical"
vo.exrc           = true
vo.foldmethod     = 'expr'
vo.foldexpr       = 'v:lua.vim.treesitter.foldexpr()'
vo.foldenable     = true
vo.foldlevel      = 99
vo.formatoptions  = cnm
vo.swapfile       = false
vo.relativenumber = true
vo.number         = true
vo.secure         = true
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
 	gh .. "folke/snacks.nvim",
	gh .. "bluz71/vim-moonfly-colors",
	gh .. "OXY2DEV/markview.nvim",
	gh .. "christoomey/vim-tmux-navigator",
	gh .. "nvim-treesitter/nvim-treesitter" ,
	gh .. 'neovim/nvim-lspconfig',
	gh .. 'tpope/vim-dispatch',
	gh .. 'ibhagwan/fzf-lua',
	gh .. 'powerman/vim-plugin-AnsiEsc',
})

-- COLORSCHEME --
local c = vim.cmd
c.colorscheme("moonfly")

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
--- MARKVIEW ---
 require("markview").setup({
   latex = {
     enable = false,
   },
 })

require 'snacks' .setup {
       image = {
               formats = {
                       "png",
                       "jpg",
                       "jpeg",
                       "webp",
                       "pdf",
               },
               force = false,
               doc = {
                       enabled = true,
                       -- only used if `opts.inline` is disabled
                       float = true,
                       max_width = 80,
                       max_height = 40,
                       conceal = function(lang, type)
                               return type == "math"
                       end,
               },
               img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },
       }
}


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
lse('tinymist')

-- KEYS --
local m = va.nvim_set_keymap
local function nm(x, y, r) m('n', x, y, {silent = true, noremap = not r}) end
local function im(x, y, r) m('i', x, y, {silent = true, noremap = not r}) end
local function vm(x, y, r) m('v', x, y, {silent = true, noremap = not r}) end
local function bnm(x, y, r, b) vim.keymap.set('n', x, y, {buffer = b, silent = true, noremap = not r}) end
local function bim(x, y, r, b) vim.keymap.set('i', x, y, {buffer = b, silent = true, noremap = not r}) end
local function bvm(x, y, r, b) vim.keymap.set('v', x, y, {buffer = b, silent = true, noremap = not r}) end

-- STARTUP --
local p = vim.fn.getcwd()
for _ = 1, 5 do
  if vim.fn.filereadable(p .. "/venv/bin/python") == 1 then
  	vim.env.PATH = p .. "/venv/bin:" .. vim.env.PATH
  	vim.env.VIRTUAL_ENV = p .. "/venv"
	vim.fn.setenv("PATH", vim.env.PATH)
	vim.fn.setenv("VIRTUAL_ENV", vim.env.VIRTUAL_ENV)
  end
  p = vim.fn.fnamemodify(p, ":h")
end
vim.g.mapleader = " "
nm('<leader>rc', ':lua vim.cmd("e " .. vim.fn.system("$HOME/tools/edrc"))<CR>')
nm('<leader>frg', ':lua vim.cmd(vim.fn.system("~/tools/frg.sh -I --vim"))<CR>')

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
nm('-','<C-w>v')
nm('_','<C-w>s')


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

nm('<Tab>', '<Esc>/[)\\}"\'>]<CR><ESC>a', true)
nm('<S-Tab>', '<Esc>?[([{"\'<]<CR><ESC>a', true)


-- AUTOCOMMANDS --
local a = va.nvim_create_autocmd
local vfs = vim.fs
local vfn = vim.fn


a("BufEnter", { 
	callback = function() 
		root = vfs.root(0, { '.git', '.clangd', 'Makefile' } )
		if root then
			vfn.chdir(root)
			vim.opt_local.path:append(root)
		end
	end})

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
		bnm('<leader>ldb', require('fzf-lua').diagnostics_document,  false, event.buf)
		bnm('<leader>ldw', require('fzf-lua').diagnostics_workspace, false, event.buf)
		bnm('gI',        ':lua vim.lsp.buf.implementation()<CR>', false, event.buf)
		bnm('<leader>D', ':lua vim.lsp.buf.type_definition()<CR>', false, event.buf)
		bnm('<leader>rn',':lua vim.lsp.buf.rename()<CR>', false, event.buf)
		bnm('<leader>ca',':lua vim.lsp.buf.code_action()<CR>', false, event.buf)
		bnm('C-K',       ':lua vim.lsp.buf.hover()<CR>', false, event.buf)
		bnm('C-K',':lua vim.lsp.buf.hover()<CR>', false, event.buf)
	end })

a({ "BufRead", "BufNewFile" }, {
  pattern = "*.inc",
  callback = function()
    vim.bo.filetype = "bitbake"
  end,
})
