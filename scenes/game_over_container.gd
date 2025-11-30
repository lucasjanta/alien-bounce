extends PanelContainer

@onready var alien_label = $MarginContainer/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/AlienLabel
@onready var score_label = $MarginContainer/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/ScoreLabel
@onready var high_score_label = $MarginContainer/VBoxContainer/PanelContainer/HighScoreLabel


func _ready():
	high_score_label.visible = false

func show_score():
	alien_label.text = str(Global.alien_count)
	score_label.text = str(Global.score)
	if Global.check_highscore():
		high_score_label.visible = true
	
