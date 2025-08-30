-- HELPERS --
local vo = vim.opt
local c = vim.cmd
local m = vim.api.nvim_set_keymap
local bm = vim.api.nvim_buf_set_keymap
local a = vim.api.nvim_create_autocmd
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
	{ src = "https://github.com/stevearc/oil.nvim"},
	{ src = "https://github.com/rafamadriz/friendly-snippets"}
})

require 'oil'.setup()
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
			inline = true,
			-- render the image in a floating window
			-- only used if `opts.inline` is disabled
			float = true,
			max_width = 80,
			max_height = 40,
			conceal = function(lang, type)
				return type == "math"
			end,
		},
		img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },
		wo = { -- window opts
			wrap = false,
			number = false,
			relativenumber = false,
			cursorcolumn = false,
			signcolumn = "no",
			foldcolumn = "0",
			list = false,
			spell = false,
			statuscolumn = "",
		},
		cache = vim.fn.stdpath("cache") .. "/snacks/image",

		icons = {
			math = "󰪚 ",
			chart = "󰄧 ",
			image = " ",
		},
		math = {
			enabled = true,
			typst = {
				tpl = [[
		#set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
		#show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
		#set text(size: 12pt, fill: rgb("${color}"))
		${header}
		${content}]],
			},
			latex = {
				font_size = "Large",
				packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
				tpl = [[
		\documentclass[preview,border=0pt,varwidth,12pt]{standalone}
		\usepackage{${packages}}
		\begin{document}
		${header}
		{ \${font_size} \selectfont
		  \color[HTML]{${color}}
		${content}}
		\end{document}]],
			},
		},
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
vo.formatoptions  = cnm
vo.swapfile       = false
vo.relativenumber = true
vo.shiftwidth     = 4
vo.softtabstop    = 4
vo.tabstop        = 4
vo.winborder      = "rounded"

c("colorscheme catppuccin")
c(":hi statusline guibg=NONE")

-- KEYS --
vim.g.mapleader = " "

nm('<leader>fc',':e ~/.config/nvim/init.lua<CR>')
nm('-', '<CMD>Oil<CR>')

nm('<leader>mm',':make<CR>')
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

local project_type = ''

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
		bnm('gd',        ':lua vim.lsp.buf.definition<CR>', {buffer = event.buf})
		bnm('gr',        ':lua vim.lsp.buf.references<CR>', {buffer = event.buf})
		nm('gI',         ':lua vim.lsp.buf.implementation<CR>')
		nm('<leader>D',  ':lua vim.lsp.buf.type_definition<CR>')
		nm('<leader>rn', ':lua vim.lsp.buf.rename<CR>')
		nm('<leader>ca', ':lua vim.lsp.buf.code_action<CR>')
		nm('K',':lua vim.lsp.buf.hover')
	end, })

a('LspAttach', {
	pattern = { '*.c', '*.cpp', '*.h', '*.hpp' },
	callback = function(event)
		nm('<leader>sh', ':ClangdSwitchSourceHeader<CR>')
		nm('<leader>st', ':ClangdTypeHierarchy<CR>')
		nm('<leader>sm', ':ClangdMemoryUsage<CR>')
		nm('<leader>ss', ':ClangdSymbolInfo<CR>')
	end,
})

a('BufWritePre', {
  pattern = { '*.c', '*.cpp', '*.h', 'hpp' },
  callback = function()
    lsb.format()
  end,
})
