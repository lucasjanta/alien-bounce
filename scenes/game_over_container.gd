extends PanelContainer

@onready var alien_label = $MarginContainer/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/AlienLabel
@onready var score_label = $MarginContainer/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/ScoreLabel


func show_score():
	alien_label.text = str(Global.alien_count)
	score_label.text = str(Global.score)
	
