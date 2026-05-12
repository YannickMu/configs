-- Hyprland Lua config (converted from hyprland.conf)
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/
--
-- Split your config into multiple files and load them like this:
-- require("myColors")

----------------
-- SECURITY   --
----------------

hl.config({
    ecosystem = {
        enforce_permissions = true,
    },
})

hl.permission("/usr/bin/hyprlock",  "screencopy", "allow")
hl.permission("/usr/bin/grim",      "screencopy", "allow")
hl.permission("/usr/bin/slurp",     "screencopy", "allow")
hl.permission("at-translated-set-2-keyboard", "keyboard", "allow")
hl.permission("video-bus",          "keyboard", "allow")
hl.permission("power-button",       "keyboard", "allow")
hl.permission("sleep-button",       "keyboard", "allow")
hl.permission("thinkpad-extra-buttons", "keyboard", "allow")
hl.permission(".*",                 "screencopy", "ask")
hl.permission(".*",                 "plugin",     "ask")
hl.permission(".*",                 "keyboard",   "ask")


--------------
-- MONITORS --
--------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

hl.monitor({
  output     = "eDP-1",
  mode       = "1920x1080@60.02",
  position   = "0x0",
  scale      = "1.0",
})

-- require("monitors")  -- source = ~/.config/hypr/monitors.conf

hl.layer_rule({
    match = { namespace = "waybar" },
    blur  = true,
})

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})


-----------------
-- MY PROGRAMS --
-----------------

local terminal   = "kitty"
local fileManager = "thunar"
local menu       = "yofi"


-------------
-- AUTOSTART --
-------------

-- exec-once: runs once at startup
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprlock")
    hl.exec_cmd("qs")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 15")
    hl.exec_cmd("pulseaudio -D")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("blueman-applet")
end)

-- exec: runs on every config reload
hl.exec_cmd("awww img ~/wallpaper/wallpaper.gif")
hl.exec_cmd("waycorner")


-------------------------
-- ENVIRONMENT VARIABLES --
-------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE",    "14")
hl.env("HYPRCURSOR_SIZE", "14")
-- hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("GTK_THEME",       "Adwaita:dark")


-------------------
-- LOOK AND FEEL --
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 5,

        border_size = 1,

        col = {
            active_border   = { colors = { "rgba(dd44ccee)", "rgba(4444ddee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding = 10,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        -- shadow = {
        --     enabled      = true,
        --     range        = 4,
        --     render_power = 3,
        --     color        = 0xee1a1a1a,
        -- },

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
})

-- Bezier curves
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

-- Animations
hl.animation({ leaf = "windows",    enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default",  style = "popin 80%" })
hl.animation({ leaf = "border",     enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade",       enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default",  style = "slidevert" })


-----------------
-- LAYOUT OPTS --
-----------------

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
hl.config({
    dwindle = {
        preserve_split = true,
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Basics/Variables/#misc
hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = false,
    },
})


-----------
-- INPUT --
-----------

-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
    input = {
        kb_layout  = "ch",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 0, -- -1.0 to 1.0; 0 = no modification

        touchpad = {
            natural_scroll = true,
        },
    },
})

-- Gestures
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#gestures
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "vertical",   action = "workspace" })

-- Per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

-----------------
-- KEYBINDINGS --
-----------------

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
local mainMod = "SUPER"

-- Apps & actions
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("/home/smuely/.config/wlogout/start.sh"))
hl.bind(mainMod .. " + L",      hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + N",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + K",      hl.dsp.exit())
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P",      hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J",      hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + Tab",    hl.dsp.window.fullscreen(1))
hl.bind(mainMod .. " + F",      hl.dsp.window.fullscreen(0))
hl.bind(mainMod .. " + C",      hl.dsp.exec_cmd("/home/smuely/.config/hypr/capture.sh"))

-- Move focus with arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces and move windows (1-10)
for i = 1, 10 do
    local key = i % 10  -- 10 maps to the "0" key
    hl.bind(mainMod .. " + " .. key,           hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,   hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces with mainMod + scroll wheel
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + mouse drag
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Brightness (locked + repeating)
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"), { locked = true, repeating = true })

-- Audio (mix of locked and repeating flags)
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SINK@ toggle"))
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),         { repeating = true })

-- Cycle windows with Alt+Tab
hl.bind("ALT + Tab", function()  
    hl.dispatch(hl.dsp.window.cycle_next())    -- Change focus to another window  
    hl.dispatch(hl.dsp.window.bring_to_top()) -- Bring it to the top  
end)


----------------------------
-- WINDOWS AND WORKSPACES --
----------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
hl.window_rule({
    name        = "no-border-rounding-wtv1",
    match       = { float = false, workspace = "w[tv1]" },
    border_size = 0,
    rounding    = 0,
})

hl.window_rule({
    name        = "no-border-rounding-f1",
    match       = { float = false, workspace = "f[1]" },
    border_size = 0,
    rounding    = 20,
})
