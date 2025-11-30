extends Node2D
@onready var tutorial_1_text = $Tutorial1Text
@onready var tutorial_3_text = $Tutorial3Text
@onready var animation_player = $AnimationPlayer


var second_tutorial_text = "Press [b]Space[/b] to jump"
var fourh_tutorial_text = "If you land [b]on your feet[/b], you successfully [b]score the points[/b]"
var fifth_tutorial_text = "If you land [b]on your head[/b], you [b]don’t get the points[/b] and [b]lose a life[/b]"

func _ready():
	animation_player.play("1")

func _on_button_1_pressed():
	animation_player.play("2")


func _on_button_2_pressed():
	animation_player.play("3")


func _on_button_3_pressed():
	animation_player.play("4")


func _on_button_4_pressed():
	animation_player.play("5")


func _on_button_5_pressed():
	animation_player.play("1")
