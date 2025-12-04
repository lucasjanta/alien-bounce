extends Control

@onready var hearts = $CanvasLayer/hearts


func _ready():
	if Global.mobile_controls:
		$CanvasLayer/MobileControls.visible = true
		$CanvasLayer/TouchScreenButton.visible = true
	else:
		$CanvasLayer/MobileControls.visible = false
		$CanvasLayer/TouchScreenButton.visible = false
		
	Global.ui_label = $CanvasLayer/ScoreContainer/MarginContainer/HBoxContainer/ScoreLabel
	Global.hearts_animation = $CanvasLayer/hearts
