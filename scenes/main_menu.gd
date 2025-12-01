extends Control
@onready var alien = $alien
@onready var bounce = $bounce
@onready var highscore_label = $HighscoreLabel

func _ready():
	highscore_label.text = "Highscore: " + str(Global.load_highscore())
	

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
