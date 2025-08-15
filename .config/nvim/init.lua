-- HELPERS --
local vo = vim.opt
local c = vim.cmd
local m = vim.api.nvim_set_keymap
local o_snr = {silent = true, noremap = true}
local o_sr = {silent = true}
local function nm(x, y) m('n', x, y, o_snr) end
local function im(x, y) m('i', x, y, o_snr) end
local function vm(x, y) m('v', x, y, o_snr) end
local function nmr(x, y) m('n', x, y, o_sr) end
local function imr(x, y) m('i', x, y, o_sr) end
local function vmr(x, y) m('v', x, y, o_sr) end

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
