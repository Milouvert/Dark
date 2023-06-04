extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const CAM_SPEED = 0.005
var movement_disabled = false
const SWAY = 0.2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var footsteps_audio: AudioStream = preload("res://audio/walking.mp3")

@onready var CAM: Camera3D = $Camera3D
@onready var ANIM = $AnimationPlayer
@onready var AUDIO_FOOT = $AudioStreamFootsteps

@onready var FLASH = $Hand/flashlight
@onready var HAND = $Hand
@onready var HAND_LOC = $HandLoc

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	AUDIO_FOOT.stream = footsteps_audio
	
func _unhandled_input(event):
	if movement_disabled: return
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * CAM_SPEED)
		
		CAM.rotate_x(-event.relative.y * CAM_SPEED)
		CAM.rotation.x = clamp(CAM.rotation.x, -PI/4, PI/4)
		
	if event.is_action_pressed("action"):
		FLASH.turn_on_off()
		
func _process(_delta):
	# rotation lerp
	HAND.global_position = HAND_LOC.global_position
	HAND.rotation.x = lerp_angle(HAND.rotation.x, CAM.rotation.x, SWAY)
	HAND.rotation.y = lerp_angle(HAND.rotation.y, rotation.y, SWAY)
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back") if !movement_disabled else Vector2.ZERO
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if input_dir != Vector2.ZERO:
		ANIM.play("walk")
		if !AUDIO_FOOT.playing:
			AUDIO_FOOT.play()
	else:
		ANIM.play("idle")
		AUDIO_FOOT.stop()

	move_and_slide()
