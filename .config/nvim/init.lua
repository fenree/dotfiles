-- HELPERS --
local v = vim.opt
local c = vim.cmd
local function nm(x, y) vim.api.nvim_set_keymap('n', x, y, {silent = true}) end
local function im(x, y) vim.api.nvim_set_keymap('i', x, y, {silent = true}) end
local function vm(x, y) vim.api.nvim_set_keymap('v', x, y, {silent = true}) end

-- PLUGINS --
vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim"},
	{ src = "https://github.com/chomosuke/typst-preview.nvim"},
	{ src = "https://github.com/echasnovski/mini.files"},
	{ src = "https://github.com/echasnovski/mini.pick"},
	{ src = "https://github.com/folke/snacks.nvim"},
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

require 'mini.files'.setup()
require 'mini.pick'.setup()
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
			inline = false,
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

-- KEYS --
vim.g.mapleader = " "

nm('<leader>fc',':e ~/.config/nvim/init.lua<CR>')
nm('<leader>pf',':Pick files<CR>')
nm('<leader>ph',':Pick help<CR>')
nm('<leader>mm',':make<CR>')

-- OPTIONS --
v.autoindent     = true
v.autoread       = true
v.formatoptions  = cnm
v.swapfile       = false
v.relativenumber = true
v.shiftwidth     = 4
v.softtabstop    = 4
v.tabstop        = 4
v.winborder      = "rounded"

c("colorscheme catppuccin")
c(":hi statusline guibg=NONE")
