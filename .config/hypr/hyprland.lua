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
        gaps_in  = 5,
        gaps_out = 20,

        border_size = 2,

        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

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
	master = {
		new_status = master
	},
	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
	},
	input = {
		kb_layout = dk,
		--    kb_variant =
		--    kb_model =
		--    kb_options =
		--    kb_rules =

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = false
		}
	},

})
--local function hla(s1, speed, curve[, style]) = 
--        NAME,           X0,   Y0,   X1,   Y1
hl.curve("easeOutQuint",   { type = "bezier", points =  {{ 0.23, 1    }, { 0.32, 1 }}})
hl.curve("easeInOutCubic", { type = "bezier", points =  {{ 0.65, 0.05 }, { 0.36, 1 }}})
hl.curve("linear",         { type = "bezier", points =  {{ 0,    0    }, { 1,    1 }}})
hl.curve("almostLinear",   { type = "bezier", points =  {{ 0.5,  0.5  }, { 0.75, 1 }}})
hl.curve("quick",          { type = "bezier", points =  {{ 0.15, 0    }, { 0.1,  1 }}})

--          NAME,          ONOFF, SPEED, CURVE,        [STYLE]
hl.animation({ leaf  = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf  = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf  = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf  = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf  = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf  = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf  = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf  = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf  = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf  = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf  = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear", style = "fade" })
hl.animation({ leaf  = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf  = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf  = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf  = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf  = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf  = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })


-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- workspace = w[tv1], gapsout:0, gapsin:0
-- workspace = f[1], gapsout:0, gapsin:0
-- windowrule {
--     name = no-gaps-wtv1
--     match:float = false
--     match:workspace = w[tv1]
--
--     border_size = 0
--     rounding = 0
-- }
--
-- windowrule {
--     name = no-gaps-f1
--     match:float = false
--     match:workspace = f[1]
--
--     border_size = 0
--     rounding = 0
-- }






-----------
-- INPUT --
-----------

-- Example per-device config
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


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


for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind("ALT" .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind("ALT" .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end
-- Switch workspaces with mainMod + [0-9]
--hl.bind("ALT + 1", hd.focus({1,true}))
--hl.bind("ALT + 2", hd.focus({2,true}))
--hl.bind("ALT + 3", hd.focus({3,true}))
--hl.bind("ALT + 4", hd.focus({4,true}))
--hl.bind("ALT + 5", hd.focus({5,true}))
--hl.bind("ALT + 6", hd.focus({6,true}))
--hl.bind("ALT + 7", hd.focus({7,true}))
--hl.bind("ALT + 8", hd.focus({8,true}))
--hl.bind("ALT + 9", hd.focus({9,true}))
--hl.bind("ALT + 0", hd.focus({10,true}))



-- Move active window to a workspace with mainMod + SHIFT + [0-9]
--hl.bind("LALT + SHIFT + 1", hdw.move({1, true}))
--hl.bind("LALT + SHIFT + 2", hdw.move({2, true}))
--hl.bind("LALT + SHIFT + 3", hdw.move({3, true}))
--hl.bind("LALT + SHIFT + 4", hdw.move({4, true}))
--hl.bind("LALT + SHIFT + 5", hdw.move({5, true}))
--hl.bind("LALT + SHIFT + 6", hdw.move({6, true}))
--hl.bind("LALT + SHIFT + 7", hdw.move({7, true}))
--hl.bind("LALT + SHIFT + 8", hdw.move({8, true}))
--hl.bind("LALT + SHIFT + 9", hdw.move({9, true}))
--hl.bind("LALT + SHIFT + 0", hdw.move({10, true}))


-- Example special workspace (scratchpad)
hl.bind("ALT + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind("ALT + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
-- Scroll through existing workspaces with mainMod + scroll
hl.bind("ALT + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("ALT + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind("mouse:272", hdw.drag(), { mouse = true })
hl.bind("mouse:273", hdw.resize(), { mouse = true })

----------------------------
-- WINDOWS AND WORKSPACES --
----------------------------

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
