config.bind('M', 'spawn mpv "{url}"')
config.bind('<Space>fc', ':config-edit')
config.load_autoconfig()

c.editor.command = ['st','-t','float','-e','nvim','{file}']
f = c.fonts
f.default_size = "16pt"
f.default_family = "IosevkaNerdFontMono"
f.statusbar = "24pt IosevkaNerdFontMono"

palette = {
    "rosewater": "#f5e0dc",
    "flamingo": "#f2cdcd",
    "pink": "#f5c2e7",
    "mauve": "#cba6f7",
    "red": "#f38ba8",
    "maroon": "#eba0ac",
    "peach": "#fab387",
    "yellow": "#f9e2af",
    "green": "#a6e3a1",
    "teal": "#94e2d5",
    "sky": "#89dceb",
    "sapphire": "#74c7ec",
    "blue": "#89b4fa",
    "lavender": "#b4befe",
    "text": "#cdd6f4",
    "subtext1": "#bac2de",
    "subtext0": "#a6adc8",
    "overlay2": "#9399b2",
    "overlay1": "#7f849c",
    "overlay0": "#6c7086",
    "surface2": "#585b70",
    "surface1": "#45475a",
    "surface0": "#313244",
    "base": "#1e1e2e",
    "mantle": "#181825",
    "crust": "#11111b",
}
col = c.colors
col.webpage.darkmode.enabled = True
# completion {{{
cmp = col.completion
cmp.category.bg = palette["base"]
cmp.category.border.bottom = palette["mantle"]
cmp.category.border.top = palette["overlay2"]
cmp.category.fg = palette["green"]
cmp.even.bg = palette["mantle"]
cmp.odd.bg = palette["crust"]
cmp.fg = palette["subtext0"]
cmp.item.selected.bg = palette["surface2"]
cmp.item.selected.border.bottom = palette["surface2"]
cmp.item.selected.border.top = palette["surface2"]
cmp.item.selected.fg = palette["text"]
cmp.item.selected.match.fg = palette["rosewater"]
cmp.match.fg = palette["text"]
cmp.scrollbar.bg = palette["crust"]
cmp.scrollbar.fg = palette["surface2"]
# }}}

# downloads {{{
dl = col.downloads
dl.bar.bg = palette["base"]
dl.error.bg = palette["base"]
dl.error.fg = palette["red"]
dl.start.bg = palette["base"]
dl.start.fg = palette["blue"]
dl.stop.bg = palette["base"]
dl.stop.fg = palette["green"]
dl.system.fg = "none"
dl.system.bg = "none"
# }}}

# hints {{{
hints = col.hints
hints.bg = palette["peach"]
hints.fg = palette["mantle"]
hints.match.fg = palette["subtext1"]

c.hints.border = "1px solid " + palette["mantle"]

# }}}

# keyhints {{{
keyhint = col.keyhint
keyhint.bg = palette["mantle"]
keyhint.fg = palette["text"]
keyhint.suffix.fg = palette["subtext1"]
# }}}

# messages {{{
msgs = col.messages
msgs.error.bg = palette["overlay0"]
msgs.info.bg = palette["overlay0"]
msgs.warning.bg = palette["overlay0"]
msgs.error.border = palette["mantle"]
msgs.info.border = palette["mantle"]
msgs.warning.border = palette["mantle"]
msgs.error.fg = palette["red"]
msgs.info.fg = palette["text"]
msgs.warning.fg = palette["peach"]
# }}}

# prompts {{{
prompts = col.prompts
prompts.bg = palette["mantle"]
prompts.border = "1px solid " + palette["overlay0"]
prompts.fg = palette["text"]
prompts.selected.bg = palette["surface2"]
prompts.selected.fg = palette["rosewater"]
# }}}

# statusbar {{{
bar = col.statusbar
bar.normal.bg = palette["base"]
bar.insert.bg = palette["crust"]
bar.command.bg = palette["base"]
bar.caret.bg = palette["base"]
bar.caret.selection.bg = palette["base"]
bar.progress.bg = palette["base"]
bar.passthrough.bg = palette["base"]
bar.normal.fg = palette["text"]
bar.insert.fg = palette["rosewater"]
bar.command.fg = palette["text"]
bar.passthrough.fg = palette["peach"]
bar.caret.fg = palette["peach"]
bar.caret.selection.fg = palette["peach"]
bar.url.error.fg = palette["red"]
bar.url.fg = palette["text"]
bar.url.hover.fg = palette["sky"]
bar.url.success.http.fg = palette["teal"]
bar.url.success.https.fg = palette["green"]
bar.url.warn.fg = palette["yellow"]
bar.private.bg = palette["mantle"]
bar.private.fg = palette["subtext1"]
bar.command.private.bg = palette["base"]
bar.command.private.fg = palette["subtext1"]

# }}}

# tabs {{{
tab = col.tabs
tab.bar.bg = palette["crust"]
tab.even.bg = palette["surface2"]
tab.odd.bg = palette["surface1"]
tab.even.fg = palette["overlay2"]
tab.odd.fg = palette["overlay2"]
tab.indicator.error = palette["red"]
tab.indicator.system = "none"
tab.selected.even.bg = palette["base"]
tab.selected.even.fg = palette["text"]
tab.selected.odd.bg = palette["base"]
tab.selected.odd.fg = palette["text"]
# }}}

# context menus {{{
cmenu = col.contextmenu
cmenu.menu.bg = palette["base"]
cmenu.menu.fg = palette["text"]
cmenu.disabled.bg = palette["mantle"]
cmenu.disabled.fg = palette["overlay0"]
cmenu.selected.bg = palette["overlay0"]
cmenu.selected.fg = palette["rosewater"]
# }}}
