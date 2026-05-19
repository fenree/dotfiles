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

local terminal = "foot -e tmux new-session -As 0"
local fileManager = "dolphin"
local menu = "foot -T float -e ~/tools/stmenu.sh"

---------------------------
-- ENVIRONMENT VARIABLES --
---------------------------

hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)


local hd = hl.dsp
local hdw = hd.window
hl.on("hyprland.start", function () 
	--hd.exec_cmd(terminal)

	hd.exec_cmd("tmux set-environment -t 0 XCURSOR_SIZE 24")
	hd.exec_cmd("tmux set-environment -t 0 HYPRCURSOR_SIZE 24")
end)

------------
-- COLORS --
------------
local color = {}
for name, hex in pairs({
    rosewater = "f5e0dc", flamingo = "f2cdcd",
    pink      = "f5c2e7", mauve    = "cba6f7", red      = "f38ba8",
    maroon    = "eba0ac", peach    = "fab387", lavender = "b4befe",
    yellow    = "f9e2af", green    = "a6e3a1", teal     = "94e2d5",
    sky       = "89dceb", sapphire = "74c7ec", blue     = "89b4fa",
    text      = "cdd6f4", subtext0 = "a6adc8", subtext1 = "bac2de",
	overlay0  = "6c7086", overlay1 = "7f849c", overlay2 = "9399b2",
    surface0  = "313244", surface1 = "45475a", surface2 = "585b70",
    base      = "1e1e2e", mantle   = "181825", crust    = "11111b",
}) do
    color[name] = {
        rgb  = "rgb("  .. hex .. ")",
        rgba = "rgba(" .. hex .. "aa)",
    }
end

-------------------
-- LOOK AND FEEL --
-------------------
local function gradient(col1, col2) return { colors = { color[col1].rgb, color[col1].rgba }, angle = 45 } end
hl.config({
    general = {
        gaps_in  = 15,
        gaps_out = 30,
        border_size = 2,
        resize_on_border = false,
        allow_tearing = false,
		layout = "master",
        col = {
            active_border = gradient("mauve"),
            inactive_border = gradient("surface2"),
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

    animations = { enabled = true, },
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

hl.bind("ALT + SHIFT + Return", hd.exec_cmd(terminal))
hl.bind("ALT + N", hd.exec_cmd(terminal, {workspace = "special:terminal"}))
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
    hl.bind("ALT" .. " + " .. i, hd.focus({ workspace = i }))
    hl.bind("ALT" .. " + SHIFT + " .. i, hdw.move({ workspace = i, follow = true}))
end
hl.bind("ALT + T",         hd.workspace.toggle_special("terminal"))
hl.bind("ALT + SHIFT + T", hdw.move({ workspace = "special:terminal" }))

hl.bind("ALT + mouse:272", hdw.drag(), { mouse = true })
hl.bind("ALT + mouse:273", hdw.resize(), { mouse = true })

-----------
-- RULES --
-----------
hl.window_rule ({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name = "suppress-maximize-events",
    match = { class = ".*" },
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
    match = { class = "hyprland-run", },
	move = { "20", "monitor_h-120" },
    float = true,
})

hl.window_rule ({
	name = "make-floatwin-float",
	match = { initial_title = "float", },
	center = true,
	float = true,
})

hl.window_rule ({
	name = "make floatmenu small",
	match = { initial_title = "float", initial_class = "foot" },
	center = true,
	float = true,
	size = { "monitor_w/2", "monitor_h/2" },
})

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})
