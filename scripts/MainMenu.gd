extends CanvasLayer

@onready var MAIN_CAM = $Background/MainCam
@onready var MOON_CAM = $Background/MoonCam
@onready var MainMenu = $GUI/MainMarginContainer
@onready var SettingsMenu = $GUI/SettingsMenuContainer

var tween: Tween

func _ready():
	SettingsMenu.back_button_pressed.connect(back_button_pressed)

func _on_join_pressed():
	var anim_dur: float = 1
	if tween:
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(MainMenu, "position", Vector2(-MainMenu.size.x, 0), 0.25)
	Transition.camera(MAIN_CAM, MOON_CAM, anim_dur)
	
	await get_tree().create_timer(anim_dur + 0.1).timeout
	get_tree().change_scene_to_file("res://scenes/Lobby.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_settings_pressed():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT_IN)
	
	tween.chain().tween_property(MainMenu, "position", Vector2(-MainMenu.size.x, 0), 0.25)
	tween.parallel().tween_property(MAIN_CAM, "h_offset", 6, 0.25)
	tween.parallel().tween_property(SettingsMenu, "position", Vector2(get_window().size.x - SettingsMenu.size.x, 0), 0.25)
	
	SettingsMenu.shown = true

func back_button_pressed():
	if tween:
		tween.kill()
	
	tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	
	tween.chain().tween_property(SettingsMenu, "position", Vector2(get_window().size.x, 0), 0.25)
	tween.parallel().tween_property(MainMenu, "position", Vector2(0, 0), 0.25)
	tween.parallel().tween_property(MAIN_CAM, "h_offset", 0, 0.25)
