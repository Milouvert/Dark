extends Node3D

@onready var PLAYER_CAM = $player/Camera3D
@onready var BILLBOARD = $world/billboard
@onready var BILLBOARD_CAM = $world/billboard/Camera3D
@onready var PLAYER = $player

var is_reading = false
var read_speed = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	PLAYER_CAM.current = true
	pass # Replace with function body.

func _unhandled_input(_event):
	pass
	#TODO: billboard?
	if Input.is_action_just_pressed("read"):
		if is_reading:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			is_reading = false
			BILLBOARD.emit_signal("mouse_exit")
			Transition.camera(BILLBOARD_CAM, PLAYER_CAM, read_speed)
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CONFINED
			is_reading = true
			BILLBOARD.emit_signal("mouse_enter")
			Transition.camera(PLAYER_CAM, BILLBOARD_CAM, read_speed)
		
		PLAYER.movement_disabled = is_reading
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
