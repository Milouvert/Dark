extends Label

func _ready():
	set_label_visibility()
	Settings.display_fps_toggle.connect(set_label_visibility)
	
func set_label_visibility():
	visible = Settings.display_fps

func _process(_delta):
	if Settings.display_fps:
		text = "FPS: " + str(Engine.get_frames_per_second())
