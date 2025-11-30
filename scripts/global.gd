extends Node

var alien_count : int = 0
var score : int = 0
var ui_label : Label
var hearts_animation : AnimatedSprite2D
var player : CharacterBody2D
var on_floor := true
var lifes : int = 3


func update_ui():
	ui_label.text = str(score)
	match lifes:
		3:
			hearts_animation.frame = 0
		2:
			hearts_animation.frame = 1
		1:
			hearts_animation.frame = 2
		0:
			hearts_animation.frame = 3

func reset():
	score = 0
	alien_count = 0
	lifes = 3
	on_floor = true
	update_ui()
	
