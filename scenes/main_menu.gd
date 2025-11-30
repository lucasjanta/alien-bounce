extends Control
@onready var alien = $alien
@onready var bounce = $bounce



func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_tutorial_button_pressed():
	pass # Replace with function body.


func _on_quit_button_pressed():
	pass # Replace with function body.


func _on_label_2_mouse_entered():
	pass
