-- HELPERS --
local vo = vim.opt
local c = vim.cmd
local va = vim.api
local m = va.nvim_set_keymap
local bm = va.nvim_buf_set_keymap
local a = va.nvim_create_autocmd
local hl = va.nvim_set_hl
local fn = vim.fn
local fs = vim.fs
local lse = vim.lsp.enable
local lsc = vim.lsp.config
local lsb = vim.lsp.buf
local o_snr = {silent = true, noremap = true}
local o_sr = {silent = true}

local function nm(x, y) m('n', x, y, o_snr) end
local function im(x, y) m('i', x, y, o_snr) end
local function vm(x, y) m('v', x, y, o_snr) end
local function nmr(x, y) m('n', x, y, o_sr) end
local function imr(x, y) m('i', x, y, o_sr) end
local function vmr(x, y) m('v', x, y, o_sr) end

local function bnm(x, y) m('n', x, y, o_snr) end
local function bim(x, y) m('i', x, y, o_snr) end
local function bvm(x, y) m('v', x, y, o_snr) end

-- PLUGINS --
vim.pack.add({
	{ src = "https://github.com/Saghen/blink.cmp"},
	{ src = "https://github.com/catppuccin/nvim"},
	{ src = "https://github.com/chomosuke/typst-preview.nvim"},
	{ src = "https://github.com/folke/snacks.nvim"},
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/neovim/nvim-lspconfig"},
--	{ src = "https://github.com/stevearc/oil.nvim"},
	{ src = "https://github.com/luukvbaal/nnn.nvim"},
	{ src = "https://github.com/rafamadriz/friendly-snippets"}
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

require 'blink.cmp'.setup {
	appearance = { nerd_font_variant = 'mono' },
	completion = { documentation = { auto_show = true } },
	keymap = { preset = 'default' },
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' }, },
    fuzzy = { implementation = "prefer_rust_with_warning" }
}

require 'nvim-treesitter.configs'.setup {
		highlight = { 
			enable = true,
			additional_vim_regex_highlighting = false, 
            max_file_length = 10000,
		},
		indent = { enable = true, },
}

vim.treesitter.language.register('markdown_inline', 'md')
vim.treesitter.language.register('python', 'py')
vim.treesitter.language.register('json', 'json')

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
  root_markers = {
    '.clangd',
    'compile_commands.json',
    'compile_flags.txt',
    '.git'
  },
  capabilities = { offsetEncoding = { 'utf-16' }, },
})
lse('clangd')

lsc('tsserver', {
	cmd = { 'typescript-language-server', '--stdio' },
	filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
	root_markers = { 'package.json', 'tsconfig.json', '.git' },
})
lse('tsserver')

lsc('luals', {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml' },
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT'
			},
		}
	}
})
lse('luals')



-- OPTIONS --
vo.autoindent     = true
vo.autoread       = true
vo.conceallevel   = 2
vo.concealcursor  = 'n'
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

c.colorscheme("catppuccin")
hl(0, "LineNrAbove", { fg = "#89dceb" })
hl(0, "LineNrBelow", { fg = "#89dceb" })
hl(0, "LineNr", { fg = "#fab387" })
hl(0, "Normal", { bg = "none" })
hl(0, "NormalFloat", { bg = "none" })
hl(0, "StatusLine", { bg = "none" })

-- keys --
vim.g.mapleader = " "

local nnn = require("nnn").builtin
require("nnn").setup({
  mappings = {
    { "<C-t>", nnn.open_in_tab },
    { "<C-s>", nnn.open_in_split },
    { "<C-v>", nnn.open_in_vsplit },
    { "<C-p>", nnn.open_in_preview },
    { "<C-y>", nnn.copy_to_clipboard },
    { "<C-w>", nnn.cd_to_path },
    { "<C-e>", nnn.populate_cmdline },
  }
})

-- file navigation
nm('<leader>fc',':e ~/.config/nvim/init.lua<CR>')
nm('_', ':NnnExplorer<CR>')
nm('-', ':NnnPicker<CR>')

-- make
nm('<leader>mm',':make<CR>')
nm('<leader>mc',':make clean<CR>')
nm('<leader>mr',':make run<CR>')

-- buffers
nm('<leader>bk',':bd<CR>')
nm('<leader>bp',':bp<CR>')
nm('<leader>bn',':bn<CR>')

nm('<ESC>',':nohlsearch<CR>')

local table = {
	['('] = ')',
	['['] = ']',
	['{'] = '}',
	['<'] = '>',
	['"'] = '"',
	["'"] = "'"
}

for x, y in pairs(table) do
	im(x, x .. y .. '<Left>')
	im(x .. '<BS>', x)
end

imr('<Tab>', '<Esc>/[)\\}"\'>]<CR><ESC>a')
imr('<S-Tab>', '<Esc>?[([{"\'<]<CR><ESC>a')


-- AUTO CMDS -- 
local root_markers = { '.git', '.clangd', 'Makefile'}

a("BufEnter", {
	callback = function()
		local r = fs.find(root_markers, { upward = true })[1]
		if r then
			fn.chdir(fs.dirname(r))
		end
	end
})

a('LspAttach', {
	pattern = { '*' },
	callback = function(event)
		bnm('gd',        ':lua vim.lsp.buf.definition()<CR>', {buffer = event.buf})
		bnm('gr',        ':lua vim.lsp.buf.references()<CR>', {buffer = event.buf})
		nm('gI',         ':lua vim.lsp.buf.implementation()<CR>')
		nm('<leader>D',  ':lua vim.lsp.buf.type_definition()<CR>')
		nm('<leader>rn', ':lua vim.lsp.buf.rename()<CR>')
		nm('<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
		nm('C-K',':lua vim.lsp.buf.hover()<CR>')
	end, })

a('LspAttach', {
	pattern = { '*.c', '*.cpp', '*.h', '*.hpp' },
	callback = function()
		nm('<leader>sh', ':LspClangdSwitchSourceHeader<CR>')
		nm('<leader>st', ':LspClangdTypeHierarchy<CR>')
		nm('<leader>sm', ':LspClangdMemoryUsage<CR>')
		nm('<leader>ss', ':LspClangdSymbolInfo<CR>')
	end,
})

a('BufWritePre', {
  pattern = { '*.c', '*.cpp', '*.h', 'hpp' },
  callback = function()
    lsb.format()
  end,
})

a('FileType', {
  pattern = 'c',
  callback = function()
    vim.wo.conceallevel = 2
  end
})
