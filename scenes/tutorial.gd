extends Node2D
@onready var tutorial_1_text = $Tutorial1Text
@onready var tutorial_3_text = $Tutorial3Text
@onready var animation_player = $AnimationPlayer

var first_tutorial_text = "Move left and right using [b]A/D[/b] or the [b]Arrow Keys[/b]"
var second_tutorial_text = "Press [b]Space[/b] to jump"
var third_tutorial_text = "Jumping on an alien makes your character [b]spin 180°[/b] and [b]doubles your points[/b]"
var fourth_tutorial_text = "If you land [b]on your feet[/b], you successfully [b]score the points[/b]"
var fifth_tutorial_text = "If you land [b]on your head[/b], you [b]don’t get the points[/b] and [b]lose a life[/b]"

func _ready():
	animation_player.play("1")

func _on_button_1_pressed():
	tutorial_1_text.text = first_tutorial_text
	animation_player.play("1")


func _on_button_2_pressed():
	tutorial_1_text.text = second_tutorial_text
	animation_player.play("2")


func _on_button_3_pressed():
	tutorial_3_text.text = third_tutorial_text
	animation_player.play("3")


func _on_button_4_pressed():
	tutorial_3_text.text = fourth_tutorial_text
	animation_player.play("4")


func _on_button_5_pressed():
	tutorial_3_text.text = fifth_tutorial_text
	animation_player.play("5")


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
