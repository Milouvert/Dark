extends Node3D

@onready var TRANS_CAM: Camera3D = $TransCam

var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func camera(from: Camera3D, to: Camera3D, duration: float = 1.0, callback: Callable = func(): pass) -> void:
	if !tween or !tween.is_valid():
		TRANS_CAM.global_transform = from.global_transform
		TRANS_CAM.fov = from.fov
	else:
		tween.kill()
	
	TRANS_CAM.current = true
	
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(true)
	
	tween.tween_property(TRANS_CAM, "global_transform", to.global_transform, duration)
	tween.tween_property(TRANS_CAM, "fov", to.fov, duration)
	tween.set_parallel(false)
	tween.tween_callback(func(): to.current = true)
	tween.tween_callback(callback)
	tween.tween_callback(tween.kill)
