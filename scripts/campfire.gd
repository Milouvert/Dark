extends StaticBody3D

@export var campfire_audio: AudioStream = preload("res://audio/campfire.mp3")

@onready var LIGHT = $OmniLight3D
@onready var AUDIO = $AudioStreamPlayer3D

var TIMER = Timer.new()
var T = 0.0

func _ready():
	
	# light timer
	add_child(TIMER)
	TIMER.one_shot = true
	TIMER.connect("timeout", set_intensity_and_restart)
	TIMER.start()
	
	# audio
	AUDIO.stream = campfire_audio
	AUDIO.play()
	
func set_intensity_and_restart():
	var E = randf_range(0.5, 0.7)
	LIGHT.light_energy = E
	
	TIMER.start(0.1)
