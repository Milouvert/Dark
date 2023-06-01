extends CanvasLayer

@onready var JOIN = $Menu/MarginContainer/VBoxContainer/Join
@onready var QUIT = $Menu/MarginContainer/VBoxContainer/Quit



func _on_join_pressed():
	get_tree().change_scene_to_file("res://scenes/Game.tscn")


func _on_quit_pressed():
	get_tree().quit()
