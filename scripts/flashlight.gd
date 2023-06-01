extends Node3D

@export var is_on: bool = true
@export var light_intensity: float = 1.0

@export var flash_on_audio: AudioStream = preload("res://audio/flash_on.mp3");
@export var flash_off_audio: AudioStream = preload("res://audio/flash_off.mp3");

@onready var LIGHT = $torch/transform/SpotLight3D
@onready var AUDIO = $torch/transform/AudioStreamPlayer3D

func turn_on_off():
	is_on = !is_on
	LIGHT.light_energy = light_intensity * float(is_on)
	
	# audio
	AUDIO.stream = flash_on_audio if is_on else flash_off_audio
	AUDIO.play()

func _ready():
	pass # Replace with function body.
