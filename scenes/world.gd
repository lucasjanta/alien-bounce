extends Node2D
@onready var game_over_container = $Control/CanvasLayer/GameOverContainer
@onready var score_animation = $ScoreAnimation
@onready var spawn_point = $SpawnPoint
@onready var spawn_point_2 = $SpawnPoint2

func _ready():
	AudioController.play_music()

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
