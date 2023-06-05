extends MarginContainer

signal back_button_pressed

@onready var DISPLAY_FPS_CHECKBOX = $VBoxContainer/DisplayFPSCheck
@onready var FPS_CAP_OPTION = $VBoxContainer/HBoxContainer/FPSOptionButton
@onready var VSYNC_CHECKBOX = $VBoxContainer/VsyncCheck

var shown = false

# Called when the node enters the scene tree for the first time.
func _ready():
	DISPLAY_FPS_CHECKBOX.set_pressed(Settings.display_fps)
	FPS_CAP_OPTION.select(FPS_CAP_OPTION.get_item_index(Settings.fps_cap))
	VSYNC_CHECKBOX.set_pressed(Settings.vsync)

func _on_back_button_pressed():
	emit_signal("back_button_pressed")

func _on_vsync_check_pressed():
	Settings.vsync = VSYNC_CHECKBOX.is_pressed()
	Settings.vsync_toggle.emit()

func _on_display_fps_check_pressed():
	Settings.display_fps = DISPLAY_FPS_CHECKBOX.is_pressed()
	Settings.display_fps_toggle.emit()

func _on_fps_option_button_item_selected(index):
	Settings.fps_cap = FPS_CAP_OPTION.get_item_id(index)
	Settings.fps_cap_change.emit()
