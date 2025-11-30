extends Control

@onready var hearts = $CanvasLayer/hearts


func _ready():
	Global.ui_label = $CanvasLayer/ScoreContainer/MarginContainer/HBoxContainer/ScoreLabel
	Global.hearts_animation = $CanvasLayer/hearts
