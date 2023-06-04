extends Node3D

@onready var CAM: Camera3D = $Camera3D

var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func transition(from: Camera3D, to: Camera3D, duration: float = 1.0, callback: Callable = func(): pass) -> void:
	if !tween or !tween.is_valid():
		CAM.global_transform = from.global_transform
		CAM.fov = from.fov
	else:
		tween.kill()
	
	CAM.current = true
	
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(true)
	
	tween.tween_property(CAM, "global_transform", to.global_transform, duration)
	tween.tween_property(CAM, "fov", to.fov, duration)
	tween.set_parallel(false)
	tween.tween_callback(callback)
	tween.tween_callback(func(): to.current = true)
	tween.tween_callback(tween.kill)
