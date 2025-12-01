extends CharacterBody2D
class_name Player

enum State { IDLE, WALK, JUMP, FLIP }
var state: State = State.IDLE
@onready var state_label = $Label
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var score_anim = $score_anim
@onready var held_score_label = $held_score_label
@onready var hurt_collision = $hurtCollision/hurtCollision
@onready var flip_collision = $FlipCollision/FlipCollision

@export var speed := 100.0
@export var jump_force := -300.0
@export var gravity := 900.0

var upside_down := false
var held_score : int = 0
var lifes := 3

func _ready():
	Global.player = self

func _physics_process(delta):
	_apply_gravity(delta)
	_handle_input()
	_process_state(delta)
	move_and_slide()

func _apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0.0 if state != State.JUMP else velocity.y

func _handle_input():
	var horizontal := Input.get_axis("left", "right")

	# Input muda estado
	if is_on_floor() and state != State.FLIP:
		if horizontal == 0:
			state = State.IDLE
			speed = 100.0
			flip_collision.disabled = true
			hurt_collision.disabled = false
			animated_sprite_2d.play("idle")
		else:
			speed = 100.0
			state = State.WALK
			flip_collision.disabled = true
			hurt_collision.disabled = false
			animated_sprite_2d.play("walk")

		if Input.is_action_just_pressed("jump"):
			AudioController.play_jump()
			speed = 100.0
			state = State.JUMP
			flip_collision.disabled = false
			hurt_collision.disabled = true
			animated_sprite_2d.play("flip")
			
		if Input.is_action_just_pressed("pause"):
			get_parent().pause_game()

func _process_state(_delta):
	match state:

		State.IDLE:
			state_label.text = "State: Idle"
			velocity.x = move_toward(velocity.x, 0, speed)

		State.WALK:
			state_label.text = "State: walk"
			var dir := Input.get_axis("left", "right")
			velocity.x = dir * speed
			if dir > 0:
				animated_sprite_2d.flip_h = false
			elif dir < 0:
				animated_sprite_2d.flip_h = true

		State.JUMP:
			animated_sprite_2d.self_modulate = Color(1, 1, 1, 1.0)
			if is_on_floor():
				velocity.y = jump_force
				Global.on_floor = false
			else:
				var dir := Input.get_axis("left", "right")
				velocity.x = dir * speed
				if dir > 0:
					animated_sprite_2d.flip_h = false
				elif dir < 0:
					animated_sprite_2d.flip_h = true
			# após pular, volta para estado adequado
			if velocity.y == 0 and is_on_floor():
				Global.on_floor = true
				state = State.IDLE
			else:
				var dir := Input.get_axis("left", "right")
				velocity.x = dir * speed

		State.FLIP:
			animated_sprite_2d.self_modulate = Color(1, 1, 1, 1.0)
			#animated_sprite_2d.flip_v = upside_down
			if is_on_floor():
				if !upside_down:
					if held_score > 0:
						AudioController.play_get_points()
					Global.score += held_score
					Global.update_ui()
					held_score = 0
					print("land and add points")
					state = State.IDLE
				else:
					#add death 
					held_score = 0
					#Global.score = 0
					animation_player.play("invincibility")
					
				Global.on_floor = true
			else:
				var dir := Input.get_axis("left", "right")
				velocity.x = dir * (speed + 50)
				if dir > 0:
					animated_sprite_2d.flip_h = false
				elif dir < 0:
					animated_sprite_2d.flip_h = true

func _on_flip_collision_area_entered(area):
	print(area)
	if area.name == "VitalArea":
		if !upside_down:
			animation_player.play("flip_anim_down")
		else:
			animation_player.play("flip_anim_up")
		upside_down = !upside_down
		state = State.FLIP
		velocity.y = jump_force
		if held_score == 0:
			held_score += 100
		else:
			held_score = held_score * 2
			
		held_score_label.text = str(held_score)
		score_anim.play("held_score_up")
	

func take_damage():
	upside_down = false
	
	if lifes > 1:
		lifes -= 1
		Global.lifes = lifes
		animated_sprite_2d.rotation = 0
		AudioController.play_hurt()
	else:
		lifes -= 1
		Global.lifes = lifes
		AudioController.play_death()
		animation_player.play("death")
		final_score()
	Global.update_ui()

func final_score():
	get_parent().final_score()


func _on_hurt_collision_area_entered(area):
	if area.name == "HitCollision":
		animation_player.call_deferred("play", "invincibility")
		
		
		
