extends Control

func _ready():
	Global.ui_label = $CanvasLayer/ScoreContainer/MarginContainer/HBoxContainer/ScoreLabel

func update_ui():
	Global.ui_label.text = str(Global.score)
