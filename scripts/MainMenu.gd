extends CanvasLayer

@onready var ANIM = $AnimationPlayer
@onready var SettingsMenu = $Menu/SettingsMenuContainer

func _ready():
	SettingsMenu.back_button_pressed.connect(back_button_pressed)

func _on_join_pressed():
	get_tree().change_scene_to_file("res://scenes/Lobby.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_settings_pressed():
	ANIM.play("open_settings")

func back_button_pressed():
	ANIM.play_backwards("open_settings")
