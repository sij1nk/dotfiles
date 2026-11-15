hl.on("hyprland.start", function()
	hl.exec_cmd("noctalia")
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 36")
	hl.exec_cmd("wl-clip-persist --clipboard both")
	hl.exec_cmd("wl-paste --watch cliphist store")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
end)

hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "48")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "48")
hl.env("WLR_DRM_NO_ATOMIC", "1")

hl.config({
	input = {
		kb_layout = "us,hu",
		kb_variant = "altgr-intl,102_qwerty_dot_nodead",
		kb_options = "caps:escape",
		follow_mouse = 1,
		-- TODO: generalize between desktop and laptop?
		tablet = {
			output = "HDMI-A-1",
			region_position = { 0.0, 0.0 },
			region_size = { 2560.0, 1440.0 },
			relative_input = false,
		},
		touchpad = {
			natural_scroll = true,
			scroll_factor = 0.3,
		},
		---@diagnostic disable-next-line
		-- sensitivity = "{{ hypr.input.sensitivity }}",
		accel_profile = "flat",
		repeat_rate = 50,
		repeat_delay = 250,
	},
	general = {
		gaps_in = 0,
		gaps_out = 0,
		border_size = 2,
		col = {
			active_border = "rgb(ebbcba)",
			inactive_border = "rgb(1f1d2e)",
		},
		resize_on_border = true,
		allow_tearing = true,
		layout = "dwindle",
	},
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		enable_swallow = true,
		swallow_regex = "^(Alacritty|scratchpad|firefox)$",
	},
	decoration = {
		rounding = 0,
		inactive_opacity = 0.88,
		blur = {
			enabled = false,
		},
		shadow = {
			enabled = true,
			range = 8,
			render_power = 3,
			color = "rgba(8a8a8aee)",
		},
	},
	animations = {
		enabled = true,
	},
	dwindle = {
		preserve_split = true,
	},
})

hl.monitor({
	output = "{{hypr.monitor.output}}",
	mode = "{{hypr.monitor.mode}}",
	position = "0x0",
	scale = "{{hypr.monitor.scale}}",
	bitdepth = 10,
	supports_wide_color = 1,
	supports_hdr = 0,
})

-- Increase sensitivity of zbook touchpad
hl.device({
	name = "elan074f:00-04f3:313a-1",
	sensitivity = 0.8,
})

-- Smart gaps / no gaps when only
hl.workspace_rule({
	workspace = "w[tv1]",
	gaps_out = 0,
	gaps_in = 0,
})
hl.workspace_rule({
	workspace = "f[1]",
	gaps_out = 0,
	gaps_in = 0,
})
hl.window_rule({
	match = {
		workspace = "w[t1]",
		float = 0,
	},
	border_size = 0,
	rounding = 0,
})
hl.window_rule({
	match = {
		workspace = "f[1]",
		float = 0,
	},
	border_size = 0,
	rounding = 0,
})

-- "Pinned" windows
hl.window_rule({
	match = {
		class = "(newsboat)",
	},
	workspace = "4",
})
hl.window_rule({
	match = {
		class = "(btop)",
	},
	workspace = "5",
})
hl.window_rule({
	match = {
		class = "(pulsemixer)",
	},
	workspace = "5",
})
hl.window_rule({
	match = {
		class = "(firefox)",
	},
	workspace = "6",
})
hl.window_rule({
	match = {
		class = "(notes)",
	},
	workspace = "8",
})
hl.window_rule({
	match = {
		class = "(ncmpcpp)",
	},
	workspace = "9",
})

hl.window_rule({
	match = {
		class = "(Firefox — Sharing Indicator)",
	},
	float = true,
	move = "0 0",
})

hl.window_rule({
	match = {
		class = "(Path of Exile)",
	},
	immediate = true,
})

hl.window_rule({
	match = {
		class = "(osu!)",
	},
	immediate = true,
})

hl.window_rule({
	match = {
		class = "(Minecraft)",
	},
	immediate = true,
})

hl.window_rule({
	match = {
		class = "(tremc)",
	},
	size = "1000 400",
})

hl.layer_rule({
	match = { namespace = "menu" },
	no_anim = true,
	dim_around = true,
})
hl.layer_rule({
	match = { namespace = "notifications" },
	no_anim = true,
})

local g = "SUPER"
local gs = "SUPER + SHIFT"
local a = "ALT"
local gc = "SUPER + CONTROL"
local gcs = "SUPER + SHIFT + CONTROL"

hl.bind(g .. " + y", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating" })

hl.bind(
	g .. " + backspace",
	hl.dsp.exec_cmd("noctalia msg keyboard-layout-cycle"),
	{ description = "Change keyboard layout" }
)
hl.bind(g .. " + n", hl.dsp.exec_cmd("plsdo workspace open_pinned notes"), { description = "Open notes" })
hl.bind(g .. " + m", hl.dsp.exec_cmd("plsdo workspace open_pinned ncmpcpp"), { description = "Open music player" })
hl.bind(g .. " + f", hl.dsp.exec_cmd("plsdo workspace open_pinned newsboat"), { description = "Open RSS reader" })
hl.bind(g .. " + w", hl.dsp.exec_cmd("plsdo workspace open_pinned Firefox"), { description = "Open browser" })
hl.bind(g .. " + v", hl.dsp.exec_cmd("plsdo workspace open_pinned pulsemixer"), { description = "Open audio mixer" })
hl.bind(g .. " + c", hl.dsp.exec_cmd("plsdo workspace open_pinned btop"), { description = "Open system monitor" })
hl.bind(g .. " + o", hl.dsp.exec_cmd("zo -m gui"), { description = "Open a zellij session" })
hl.bind(g .. " + return", hl.dsp.exec_cmd("alacritty"), { description = "Open terminal" })
hl.bind(g .. " + q", hl.dsp.window.close(), { description = "Close window" })
hl.bind(gs .. " + q", hl.dsp.exec_cmd("hyprkill"), { description = "Quit Hyprland" })
hl.bind(gs .. " + s", hl.dsp.exec_cmd("noctalia msg panel-toggle session"), { description = "Open shutdown menu" })
hl.bind(g .. " + p", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"), { description = "Open launcher" })
hl.bind(gcs .. " + bracketleft", hl.dsp.window.pseudo(), { description = "Toggle pseudo view" })
hl.bind(
	g .. " + semicolon",
	hl.dsp.window.fullscreen_state({ internal = 2, client = 2, action = "toggle" }),
	{ description = "Toggle fullscreen" }
)
hl.bind(
	gs .. " + semicolon",
	hl.dsp.window.fullscreen_state({ internal = -1, client = 2, action = "toggle" }),
	{ description = "Toggle fake fullscreen" }
)
hl.bind(gs .. " + period", hl.dsp.exec_cmd("hyprpicker | cliphist store"), { description = "Pick color" })
hl.bind(
	gs .. " + comma",
	hl.dsp.exec_cmd("cliphist list | sort -rn | bemenu --prompt 'Clipboard' -l 24 | cliphist decode | wl-copy"),
	{ description = "Show clipboard history" }
)
hl.bind(g .. " + slash", hl.dsp.exec_cmd("hypr-dispatch-keybind"), { description = "Dispatch a hyprland keybind" })
hl.bind(
	g .. " + equal",
	hl.dsp.exec_cmd("busctl --user call rs.wl-gammarelay / rs.wl.gammarelay ToggleInverted"),
	{ description = "Invert display colors" }
)
hl.bind(
	gs .. " + b",
	hl.dsp.exec_cmd("[float] pidof bluetui || alacritty -e bluetui"),
	{ description = "Open bluetooth manager" }
)
hl.bind(gs .. " + t", hl.dsp.exec_cmd("[float] tremc-wrapper"), { description = "Open torrent manager" })

hl.bind(g .. " + z", hl.dsp.submap("zoom"), { description = "Enter zoom submap" })
hl.define_submap("zoom", function()
	hl.bind(
		"mouse:272",
		hl.dsp.exec_cmd(
			"hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')"
		)
	)
	hl.bind(
		"mouse:273",
		hl.dsp.exec_cmd(
			"hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')"
		)
	)
	hl.bind("escape", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor 1"))
	hl.bind("escape", hl.dsp.submap("reset"))
end)

hl.bind(g .. " + h", hl.dsp.focus({ direction = "left" }), { description = "Focus left" })
hl.bind(g .. " + j", hl.dsp.focus({ direction = "down" }), { description = "Focus down" })
hl.bind(g .. " + k", hl.dsp.focus({ direction = "up" }), { description = "Focus up" })
hl.bind(g .. " + l", hl.dsp.focus({ direction = "right" }), { description = "Focus right" })
hl.bind(gs .. " + h", hl.dsp.window.move({ direction = "l" }), { description = "Move focused window left" })
hl.bind(gs .. " + j", hl.dsp.window.move({ direction = "d" }), { description = "Move focused window down" })
hl.bind(gs .. " + k", hl.dsp.window.move({ direction = "u" }), { description = "Move focused window up" })
hl.bind(gs .. " + l", hl.dsp.window.move({ direction = "r" }), { description = "Move focused window right" })
hl.bind(a .. " + tab", hl.dsp.exec_cmd("noctalia msg window-switcher"), { description = "Switch windows" })
hl.bind(
	gc .. " + h",
	hl.dsp.exec_cmd("plsdo workspace focus prev-current"),
	{ description = "Focus previous workspace" }
)
hl.bind(gc .. " + l", hl.dsp.exec_cmd("plsdo workspace focus next-current"), { description = "Focus next workspace" })
hl.bind(
	gcs .. " + h",
	hl.dsp.exec_cmd("plsdo workspace move prev-current"),
	{ description = "Move focused window to previous workspace" }
)
hl.bind(
	gcs .. " + l",
	hl.dsp.exec_cmd("plsdo workspace move next-current"),
	{ description = "Move focused window to next workspace" }
)

hl.bind(g .. " + 1", hl.dsp.exec_cmd("plsdo workspace focus id 1"), { description = "Focus workspace 1" })
hl.bind(g .. " + space", hl.dsp.exec_cmd("plsdo workspace focus id 1"), { description = "Focus workspace 1" })
hl.bind(g .. " + 2", hl.dsp.exec_cmd("plsdo workspace focus id 2"), { description = "Focus workspace 2" })
hl.bind(g .. " + 3", hl.dsp.exec_cmd("plsdo workspace focus id 3"), { description = "Focus workspace 3" })
hl.bind(g .. " + 4", hl.dsp.exec_cmd("plsdo workspace focus id 4"), { description = "Focus workspace 4" })
hl.bind(g .. " + 5", hl.dsp.exec_cmd("plsdo workspace focus id 5"), { description = "Focus workspace 5" })
hl.bind(g .. " + 6", hl.dsp.exec_cmd("plsdo workspace focus id 6"), { description = "Focus workspace 6" })
hl.bind(g .. " + 7", hl.dsp.exec_cmd("plsdo workspace focus id 7"), { description = "Focus workspace 7" })
hl.bind(g .. " + 8", hl.dsp.exec_cmd("plsdo workspace focus id 8"), { description = "Focus workspace 8" })
hl.bind(g .. " + 9", hl.dsp.exec_cmd("plsdo workspace focus id 9"), { description = "Focus workspace 9" })
hl.bind(g .. " + 0", hl.dsp.exec_cmd("plsdo workspace focus id 10"), { description = "Focus workspace 0" })

hl.bind(
	gs .. " + 1",
	hl.dsp.exec_cmd("plsdo workspace move id 1"),
	{ description = "Move focused window to workspace 1" }
)
hl.bind(
	gs .. " + space",
	hl.dsp.exec_cmd("plsdo workspace focus id 1"),
	{ description = "Move focused window to workspace 1" }
)
hl.bind(
	gs .. " + 2",
	hl.dsp.exec_cmd("plsdo workspace move id 2"),
	{ description = "Move focused window to workspace 2" }
)
hl.bind(
	gs .. " + 3",
	hl.dsp.exec_cmd("plsdo workspace move id 3"),
	{ description = "Move focused window to workspace 3" }
)
hl.bind(
	gs .. " + 4",
	hl.dsp.exec_cmd("plsdo workspace move id 4"),
	{ description = "Move focused window to workspace 4" }
)
hl.bind(
	gs .. " + 5",
	hl.dsp.exec_cmd("plsdo workspace move id 5"),
	{ description = "Move focused window to workspace 5" }
)
hl.bind(
	gs .. " + 6",
	hl.dsp.exec_cmd("plsdo workspace move id 6"),
	{ description = "Move focused window to workspace 6" }
)
hl.bind(
	gs .. " + 7",
	hl.dsp.exec_cmd("plsdo workspace move id 7"),
	{ description = "Move focused window to workspace 7" }
)
hl.bind(
	gs .. " + 8",
	hl.dsp.exec_cmd("plsdo workspace move id 8"),
	{ description = "Move focused window to workspace 8" }
)
hl.bind(
	gs .. " + 9",
	hl.dsp.exec_cmd("plsdo workspace move id 9"),
	{ description = "Move focused window to workspace 9" }
)
hl.bind(
	gs .. " + 0",
	hl.dsp.exec_cmd("plsdo workspace move id 10"),
	{ description = "Move focused window to workspace 0" }
)

hl.bind(g .. " + a", hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen"), { description = "Screenshot" })
hl.bind(gs .. " + a", hl.dsp.exec_cmd("noctalia msg screenshot-region"), { description = "Screenshot region" })
hl.bind(
	gc .. " + a",
	hl.dsp.exec_cmd("noctalia msg screenshot-annotate"),
	{ description = "Screenshot with annotation" }
)

hl.bind(g .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(g .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(g .. " + bracketleft", hl.dsp.exec_cmd("noctalia msg volume-down"), { description = "Lower audio volume" })
hl.bind(g .. " + backslash", hl.dsp.exec_cmd("noctalia msg volume-mute"), { description = "Mute audio" })

-- TODO:
hl.bind(gs .. " + m", hl.dsp.exec_cmd("plsdo audio output choose"), { description = "Choose audio output" })

hl.bind(g .. " + bracketright", hl.dsp.exec_cmd("noctalia msg volume-up"), { description = "Raise audio volume" })
hl.bind(
	gs .. " + minus",
	hl.dsp.exec_cmd("noctalia msg media previous-player"),
	{ description = "Previous media player" }
)
hl.bind(gs .. " + bracketleft", hl.dsp.exec_cmd("noctalia msg media previous"), { description = "Previous audio" })
hl.bind("xf86audioprev", hl.dsp.exec_cmd("noctalia msg media previous"), { description = "Previous audio" })
hl.bind(gs .. " + backslash", hl.dsp.exec_cmd("noctalia msg media toggle"), { description = "Pause audio" })
hl.bind("xf86audioplay", hl.dsp.exec_cmd("noctalia msg media toggle"), { description = "Play audio" })
hl.bind("xf86audiopause", hl.dsp.exec_cmd("noctalia msg media toggle"), { description = "Pause audio" })
hl.bind(gs .. " + bracketright", hl.dsp.exec_cmd("noctalia msg media next"), { description = "Next audio" })
hl.bind("xf86audionext", hl.dsp.exec_cmd("noctalia msg media next"), { description = "Next audio" })
hl.bind(gs .. " + equal", hl.dsp.exec_cmd("noctalia msg media next-player"), { description = "Next media player" })

hl.bind(g .. " + b", hl.dsp.submap("resize"), { description = "Enter resize submap" })
hl.define_submap("resize", function()
	hl.bind("h", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("j", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("k", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	hl.bind("l", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("escape", hl.dsp.submap("reset"))
end)

hl.bind(g .. " + x", hl.dsp.submap("swap"), { description = "Enter swap submap" })
hl.define_submap("swap", function()
	hl.bind("h", hl.dsp.window.swap({ direction = "l" }))
	hl.bind("h", hl.dsp.submap("reset"))
	hl.bind("j", hl.dsp.window.swap({ direction = "d" }))
	hl.bind("j", hl.dsp.submap("reset"))
	hl.bind("k", hl.dsp.window.swap({ direction = "u" }))
	hl.bind("k", hl.dsp.submap("reset"))
	hl.bind("l", hl.dsp.window.swap({ direction = "r" }))
	hl.bind("l", hl.dsp.submap("reset"))
	hl.bind("escape", hl.dsp.submap("reset"))
end)

hl.bind(g .. " + comma", hl.dsp.submap("brightness"), { description = "Enter brightness submap" })
hl.define_submap("brightness", function()
	hl.bind("j", hl.dsp.exec_cmd("noctalia msg brightness-down"), { repeating = true })
	hl.bind("k", hl.dsp.exec_cmd("noctalia msg brightness-up"), { repeating = true })
	hl.bind("escape", hl.dsp.submap("reset"))
end)

hl.bind(g .. " + mouse:272", hl.dsp.window.drag())
hl.bind(g .. " + mouse:273", hl.dsp.window.resize())

hl.workspace_rule({
	workspace = "1",
	monitor = "{{hypr.monitor.output}}",
	persistent = true,
})

hl.workspace_rule({
	workspace = "2",
	monitor = "{{hypr.monitor.output}}",
	persistent = true,
})

hl.workspace_rule({
	workspace = "3",
	monitor = "{{hypr.monitor.output}}",
	persistent = true,
})

hl.workspace_rule({
	workspace = "4",
	monitor = "{{hypr.monitor.output}}",
	persistent = true,
})

hl.workspace_rule({
	workspace = "5",
	monitor = "{{hypr.monitor.output}}",
	persistent = true,
})

hl.workspace_rule({
	workspace = "6",
	monitor = "{{hypr.monitor.output}}",
	persistent = true,
	default_name = "web",
})

hl.workspace_rule({
	workspace = "7",
	monitor = "{{hypr.monitor.output}}",
	persistent = true,
})

hl.workspace_rule({
	workspace = "8",
	monitor = "{{hypr.monitor.output}}",
	persistent = true,
})

hl.workspace_rule({
	workspace = "9",
	monitor = "{{hypr.monitor.output}}",
	persistent = true,
})

hl.workspace_rule({
	workspace = "10",
	monitor = "{{hypr.monitor.output}}",
	persistent = true,
})

hl.curve("snappy", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 3,
	bezier = "snappy",
})
hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 5,
	bezier = "snappy",
	style = "popin 80%",
})
hl.animation({
	leaf = "border",
	enabled = true,
	speed = 5,
	bezier = "default",
})
hl.animation({
	leaf = "borderangle",
	enabled = true,
	speed = 8,
	bezier = "default",
})
hl.animation({
	leaf = "fade",
	enabled = true,
	speed = 3,
	bezier = "default",
})
hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 3,
	bezier = "default",
})
