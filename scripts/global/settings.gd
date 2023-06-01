extends Node

signal display_fps_toggle
var display_fps: bool = true

signal fps_cap_change
var fps_cap: int = 0

signal vsync_toggle
var vsync: bool = true

func _ready():
	set_fps_cap()
	fps_cap_change.connect(set_fps_cap)
	set_vsync()
	vsync_toggle.connect(set_vsync)

func set_fps_cap():
	Engine.set_max_fps(fps_cap)

func set_vsync():
	if vsync:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
