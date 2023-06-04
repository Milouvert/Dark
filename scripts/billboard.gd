extends Node3D

signal mouse_enter
signal mouse_exit

@onready var VP = $PanelViewport
@onready var SCREEN = $Screen
@onready var TOUCHAREA = $Area3D
@onready var TOUCHBOX = $Area3D/CollisionShape3D
@onready var CAM = $Camera3D

var mouse_inside = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	TOUCHAREA.connect("mouse_entered", mouse_entered_area)
	TOUCHAREA.connect("mouse_exited", mouse_exited_area)
	mouse_enter.connect(mouse_entered_area)
	mouse_exit.connect(mouse_exited_area)
	pass
	
func _physics_process(_delta):
	pass
	
func mouse_entered_area():
	if !mouse_inside: print("in")
	mouse_inside = true
	
func mouse_exited_area():
	if mouse_inside: print("out")
	mouse_inside = false
	
func _input(event):
	if !mouse_inside: return
	var is_mouse_event = event is InputEventMouseButton or event is InputEventMouseMotion
	
	if !is_mouse_event:
		VP.push_input(event)
		return
		
	var mouse_coords = Vector2(event.global_position.x, event.global_position.y)
	
	var toucharea_pos = TOUCHAREA.global_position
	#var cam_pos_diff = toucharea_pos - CAM.global_position
	var touchbox_size = TOUCHBOX.shape.size
	var viewport_size = VP.size
	
	var mouse_world_pos = get_mouse_world_pos(mouse_coords)
	
	if mouse_world_pos:
		#mouse_world_pos += cam_pos_diff
		var centered_world_pos = mouse_world_pos - toucharea_pos
		var normalized_world_pos = centered_world_pos
		normalized_world_pos.x /= touchbox_size.x
		normalized_world_pos.y /= touchbox_size.y
		normalized_world_pos.z /= touchbox_size.z
		
		var mouse_pos_2d = Vector2(normalized_world_pos.x + 0.5, -normalized_world_pos.y + 0.5)
		
		var viewport_pos = mouse_pos_2d
		viewport_pos.x *= viewport_size.x
		viewport_pos.y *= viewport_size.y
		
		print(viewport_pos)
	
func get_mouse_world_pos(mouse_pos: Vector2):
	var ray_len = 100
	var from = CAM.project_ray_origin(mouse_pos)
	var to = from + CAM.project_ray_normal(mouse_pos) * ray_len
	var result = get_world_3d().direct_space_state.intersect_ray(PhysicsRayQueryParameters3D.create(from, to))
	if !result.is_empty():
		return result.position
	else:
		return null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var tex = VP.get_texture()
	var mat = SCREEN.get_surface_override_material(0)
	mat.albedo_texture = tex
