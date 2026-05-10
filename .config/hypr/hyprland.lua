--------------
-- MONITORS --
--------------

hl.monitor({
  output = "DP-3",
  mode = "2560x1440@165",
  position = "0x0",
  scale = 1,
})

-----------------
-- MY PROGRAMS --
-----------------

local terminal = "foot"
local fileManager = "dolphin"
local menu = "foot -T float -e ~/suckless/dwm/scripts/stmenu.sh"

local rosewater = "rgb(f5e0dc)"
local rosewaterAlpha = "rgba(f5e0dcaa)"

local flamingo = "rgb(f2cdcd)"
local flamingoAlpha = "rgba(f2cdcdaa)"

local pink = "rgb(f5c2e7)"
local pinkAlpha = "rgba(f5c2e7aa)"

local mauve = "rgb(cba6f7)"
local mauveAlpha = "rgba(cba6f7aa)"

local red = "rgb(f38ba8)"
local redAlpha = "rgba(f38ba8aa)"

local maroon = "rgb(eba0ac)"
local maroonAlpha = "rgba(eba0acaa)"

local peach = "rgb(fab387)"
local peachAlpha = "rgba(fab387aa)"

local yellow = "rgb(f9e2af)"
local yellowAlpha = "rgba(f9e2afaa)"

local green = "rgb(a6e3a1)"
local greenAlpha = "rgba(a6e3a1aa)"

local teal = "rgb(94e2d5)"
local tealAlpha = "rgba(94e2d5aa)"

local sky = "rgb(89dceb)"
local skyAlpha = "rgba(89dcebaa)"

local sapphire = "rgb(74c7ec)"
local sapphireAlpha = "rgba(74c7ecaa)"

local blue = "rgb(89b4fa)"
local blueAlpha = "rgba(89b4faaa)"

local lavender = "rgb(b4befe)"
local lavenderAlpha = "rgba(b4befeaa)"

local text = "rgb(cdd6f4)"
local textAlpha = "rgba(cdd6f4aa)"

local subtext1 = "rgb(bac2de)"
local subtext1Alpha = "rgba(bac2deaa)"

local subtext0 = "rgb(a6adc8)"
local subtext0Alpha = "rgba(a6adc8aa)"

local overlay2 = "rgb(9399b2)"
local overlay2Alpha = "rgba(9399b2aa)"

local overlay1 = "rgb(7f849c)"
local overlay1Alpha = "rgba(7f849caa)"

local overlay0 = "rgb(6c7086)"
local overlay0Alpha = "rgba(6c7086aa)"

local surface2 = "rgb(585b70)"
local surface2Alpha = "rgba(585b70aa)"

local surface1 = "rgb(45475a)"
local surface1Alpha = "rgba(45475aaa)"

local surface0 = "rgb(313244)"
local surface0Alpha = "rgba(313244aa)"

local base = "rgb(1e1e2e)"
local baseAlpha = "rgba(1e1e2eaa)"

local mantle = "rgb(181825)"
local mantleAlpha = "rgba(181825aa)"

local crust = "rgb(11111b)"
local crustAlpha = "rgba(11111baa)"

---------------------------
-- ENVIRONMENT VARIABLES --
---------------------------

hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)

-------------------
-- LOOK AND FEEL --
-------------------
local function gradient(col1, col2) return { colors = { col1, col2 }, angle = 45 } end
hl.config({
    general = {
        gaps_in  = 15,
        gaps_out = 30,
        border_size = 2,	
        resize_on_border = false,
        allow_tearing = false,
		layout = "master",
        col = {
            active_border = gradient(mauve, mauveAlpha),
            inactive_border = gradient(surface2, surface2Alpha),
        },
    },
    decoration = {
        rounding         = 0,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        }, blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
	master = { new_status = master },
	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = false,
	},
	input = {
		follow_mouse = 1,
		kb_layout = "dk",
		kb_variant = "nodeadkeys",
		touchpad = { natural_scroll = false }
	},
})

local function hlc(str, t1, t2) hl.curve(str,   { type = "bezier", points =  {t1, t2}}) end
--   NAME,              X0,   Y0,        X1,   Y1
hlc("easeOutQuint",   { 0.23, 1    },  { 0.32, 1 })
hlc("easeInOutCubic", { 0.65, 0.05 },  { 0.36, 1 })
hlc("linear",         { 0,    0    },  { 1,    1 })
hlc("almostLinear",   { 0.5,  0.5  },  { 0.75, 1 })
hlc("quick",          { 0.15, 0    },  { 0.1,  1 })

local function hla(str1, num, str2, style) hl.animation({ leaf = str1, enabled = true, speed = num, bezier = str2, style = style })  end
--   NAME,           SPEED, CURVE,          [STYLE]
hla("windowsIn",     4.1,   "easeOutQuint", "popin 87%")
hla("windowsOut",    1.49,  "linear",       "popin 87%")
hla("layersIn",      4,     "easeOutQuint", "fade")
hla("layersOut",     1.5,   "linear",       "fade")
hla("workspacesIn",  1.21,  "almostLinear", "fade")
hla("workspacesOut", 1.94,  "almostLinear", "fade")
hla("workspaces",    1.94,  "almostLinear", "fade")
hla("global",        10,    "default")
hla("border",        5.39,  "easeOutQuint")
hla("windows",       4.79,  "easeOutQuint")
hla("fadeIn",        1.73,  "almostLinear")
hla("fadeOut",       1.46,  "almostLinear")
hla("fade",          3.03,  "quick")
hla("layers",        3.81,  "easeOutQuint")
hla("fadeLayersIn",  1.79,  "almostLinear")
hla("fadeLayersOut", 1.39,  "almostLinear")
hla("zoomFactor",    7,     "quick")

-----------------
-- KEYBINDINGS --
-----------------
local hd = hl.dsp
local hdw = hd.window

hl.bind("ALT + SHIFT + Return", hl.dsp.exec_cmd(terminal))
hl.bind("ALT + M", hd.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))
hl.bind("ALT + E", hd.exec_cmd(fileManager))
hl.bind("ALT + P", hd.exec_cmd(menu))

hl.bind("ALT + SHIFT + C", hdw.close())
hl.bind("ALT + F", hdw.float())
hl.bind("ALT + R", hdw.pseudo())

hl.bind("ALT + H", hd.layout("mfact -0.1"))
hl.bind("ALT + L", hd.layout("mfact +0.1"))
hl.bind("ALT + J", hd.layout("cyclenext"))
hl.bind("ALT + K", hd.layout("cycleprev"))
hl.bind("ALT + Return", hd.layout("swapwithmaster"))

for i = 1, 9 do
    hl.bind("ALT" .. " + " .. i,         hd.focus({ workspace = i}))
    hl.bind("ALT" .. " + SHIFT + " .. i, hdw.move({ workspace = i}))
end
hl.bind("ALT + S",         hd.workspace.toggle_special("magic"))
hl.bind("ALT + SHIFT + S", hdw.move({ workspace = "special:magic" }))

hl.bind("ALT + mouse:272", hdw.drag(), { mouse = true })
hl.bind("ALT + mouse:273", hdw.resize(), { mouse = true })

-----------
-- RULES --
-----------
hl.window_rule ({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name = "suppress-maximize-events",
    match = {class = ".*"},

    suppress_event = "maximize"
})

hl.window_rule  ({
    -- Fix some dragging issues with XWayland
    name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
    no_focus = true
})

-- Hyprland-run windowrule
hl.window_rule ({
    name = "move-hyprland-run",
    match = {
		class = "hyprland-run",
	},
	move = { "20", "monitor_h-120" },
    float = true,
})

hl.window_rule ({
	name = "make-floatwin-centered-and-small",
	match = { initial_title = "float", },
	float = true,
})

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})
