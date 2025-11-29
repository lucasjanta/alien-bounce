extends CharacterBody2D
class_name Player

enum State { IDLE, WALK, JUMP, FLIP }
var state: State = State.IDLE
@onready var state_label = $Label
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var held_score_label = $held_score_label

@export var speed := 100.0
@export var jump_force := -300.0
@export var gravity := 900.0

var upside_down := false
var held_score : int = 0
var lifes := 3

func _physics_process(delta):
	_apply_gravity(delta)
	_handle_input()
	_process_state(delta)
	move_and_slide()

func _apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0 if state != State.JUMP else velocity.y

func _handle_input():
	var horizontal := Input.get_axis("ui_left", "ui_right")

	# Input muda estado
	if is_on_floor() and state != State.FLIP:
		if horizontal == 0:
			state = State.IDLE
		else:
			state = State.WALK

		if Input.is_action_just_pressed("ui_accept"):
			state = State.JUMP

func _process_state(delta):
	match state:

		State.IDLE:
			state_label.text = "State: Idle"
			velocity.x = move_toward(velocity.x, 0, speed)

		State.WALK:
			state_label.text = "State: walk"
			var dir := Input.get_axis("ui_left", "ui_right")
			velocity.x = dir * speed

		State.JUMP:
			state_label.text = "State: jump"
			if is_on_floor():
				velocity.y = jump_force
			else:
				var dir := Input.get_axis("ui_left", "ui_right")
				velocity.x = dir * speed
			# após pular, volta para estado adequado
			if velocity.y == 0 and is_on_floor():
				state = State.IDLE
			else:
				var dir := Input.get_axis("ui_left", "ui_right")
				velocity.x = dir * speed

		State.FLIP:
			state_label.text = "State: flip"
			animated_sprite_2d.flip_v = upside_down
			if is_on_floor():
				if upside_down:
					#add death 
					print("die")
					held_score = 0
					#Global.score = 0
					get_tree().reload_current_scene()
				else:
					Global.score += held_score
					Global.update_ui()
					held_score = 0
					print("land and add points")
					state = State.IDLE
			else:
				var dir := Input.get_axis("ui_left", "ui_right")
				velocity.x = dir * (speed + 50)

func _on_flip_collision_area_entered(area):
	print(area)
	if area.name == "VitalArea":
		upside_down = !upside_down
		state = State.FLIP
		velocity.y = jump_force
		if held_score == 0:
			held_score += 100
		else:
			held_score = held_score * 2
		held_score_label.text = str(held_score)
		animation_player.play("held_score_up")
		
			
		#animation of held score label
