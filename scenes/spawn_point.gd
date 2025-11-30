extends Node2D
@onready var marker_2d = $Marker2D
@onready var timer = $Timer
var game_over := false

const ALIEN = preload("uid://crrm51q7ugnbh")


	
func spawn_alien():
	var new_alien = ALIEN.instantiate()
	get_parent().add_child(new_alien)
	new_alien.global_position = marker_2d.global_position


func _on_timer_timeout():
	if !game_over:
		spawn_alien()
		timer.wait_time = randi_range(1,4)
		timer.start()
	else:
		pass
