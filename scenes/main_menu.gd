extends Control
@onready var alien = $alien
@onready var bounce = $bounce
@onready var highscore_label = $HighscoreLabel
@onready var music_h_slider = $VBoxContainer2/MusicContainer/MusicHSlider
@onready var sfxh_slider = $VBoxContainer2/SFXContainer/SFXHSlider
@onready var mute_button = $VBoxContainer2/MuteContainer/MuteButton

func _ready():
	highscore_label.text = "Highscore: " + str(Global.load_highscore())
	AudioController.play_main_memu_music()
	music_h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	sfxh_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	mute_button.button_pressed = AudioController.mute
	

func _on_start_button_pressed():
	Global.lifes = 3
	Global.score = 0
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_tutorial_button_pressed():
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_start_button_mouse_entered():
	AudioController.play_button_hover()


func _on_tutorial_button_mouse_entered():
	AudioController.play_button_hover()


func _on_quit_button_mouse_entered():
	AudioController.play_button_hover()


func _on_music_h_slider_value_changed(value):
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), db)


func _on_sfxh_slider_value_changed(value):
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), db)


func _on_mute_button_toggled(toggled_on):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), toggled_on)
	AudioController.mute = toggled_on


func _on_check_button_toggled(toggled_on):
	if toggled_on:
		Global.mobile_controls = true
	else:
		Global.mobile_controls = false
