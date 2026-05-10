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
local menu = "foot -e ~/suckless/dwm/scripts/stmenu.sh"


---------------------------
-- ENVIRONMENT VARIABLES --
---------------------------

hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)

-------------------
-- LOOK AND FEEL --
-------------------

hl.config({
    general = {
        gaps_in  = 15,
        gaps_out = 30,
        border_size = 2,

        col = {
            active_border = {
				colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 
			},
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing = false,
		layout = "master",
    },

    decoration = {
        rounding       = 0,
        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
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
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
	},
	input = {
		kb_layout = "dk",
		kb_variant = "nodeadkeys",

		follow_mouse = 1,
		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
		touchpad = {
			natural_scroll = false
		}
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
hl.bind("ALT + SHIFT + C", hdw.close())
hl.bind("ALT + M", hd.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))
hl.bind("ALT + E", hd.exec_cmd(fileManager))
hl.bind("ALT + F", hdw.float())
hl.bind("ALT + R", hd.exec_cmd(menu))
hl.bind("ALT + P", hdw.pseudo())

hl.bind("ALT + Return", hd.layout("swapwithmaster"))

hl.bind("ALT + h", hd.layout("mfact -0.1"))
hl.bind("ALT + l", hd.layout("mfact +0.1"))
hl.bind("ALT + j", hd.layout("cyclenext"))
hl.bind("ALT + k", hd.layout("cycleprev"))

for i = 1, 9 do
    hl.bind("ALT" .. " + " .. i,             hd.focus({ workspace = i}))
    hl.bind("ALT" .. " + SHIFT + " .. i,     hdw.move({ workspace = i }))
end
hl.bind("ALT + S",         hd.workspace.toggle_special("magic"))
hl.bind("ALT + SHIFT + S", hdw.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind("ALT + mouse_down", hd.focus({ workspace = "e+1" }))
hl.bind("ALT + mouse_up",   hd.focus({ workspace = "e-1" }))
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
})

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
