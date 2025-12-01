extends Node2D
@onready var game_over_container = $Control/CanvasLayer/GameOverContainer
@onready var score_animation = $ScoreAnimation
@onready var spawn_point = $SpawnPoint
@onready var spawn_point_2 = $SpawnPoint2

@onready var pause_menu = $Control/CanvasLayer/PauseMenu
@onready var mute_button = $Control/CanvasLayer/PauseMenu/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer2/MuteContainer/MuteButton
@onready var music_h_slider = $Control/CanvasLayer/PauseMenu/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer2/MusicContainer/MusicHSlider
@onready var sfxh_slider = $Control/CanvasLayer/PauseMenu/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer2/SFXContainer/SFXHSlider


func _ready():
	AudioController.play_music()
	music_h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	sfxh_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	mute_button.button_pressed = AudioController.mute

func final_score():
	spawn_point.game_over = true
	spawn_point_2.game_over = true
	game_over_container.show_score()
	score_animation.play("show_score")

func _on_retry_button_pressed():
	score_animation.play_backwards("show_score")
	Global.reset()
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func pause_game():
	pause_menu.visible = true
	get_tree().paused = true
	

func _on_pause_resume_button_pressed():
	pause_menu.visible = false
	get_tree().paused = false


func _on_pause_retry_button_pressed():
	get_tree().paused = false
	Global.reset()
	get_tree().reload_current_scene()


func _on_pause_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")



func _on_music_h_slider_value_changed(value):
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), db)


func _on_sfxh_slider_value_changed(value):
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), db)


func _on_mute_button_toggled(toggled_on):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), toggled_on)
	AudioController.mute = toggled_on
