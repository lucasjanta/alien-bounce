extends Node

var score : int = 0
var ui_label : Label

func update_ui():
	ui_label.text = str(score)
