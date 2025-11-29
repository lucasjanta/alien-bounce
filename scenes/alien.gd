extends CharacterBody2D

enum State { WALK_LEFT, WALK_RIGHT }
var state: State = State.WALK_RIGHT

var speed := 60.0
var gravity := 900.0

func _physics_process(delta):
	velocity.y += gravity * delta
	_process_state(delta)
	move_and_slide()

	_check_collision_and_flip()

func _process_state(delta):
	match state:
		State.WALK_RIGHT:
			velocity.x = speed
		State.WALK_LEFT:
			velocity.x = -speed

func _check_collision_and_flip():
	# Bateu em parede → troca direção
	if is_on_wall():
		if state == State.WALK_RIGHT:
			state = State.WALK_LEFT
		else:
			state = State.WALK_RIGHT

	# (opcional) Se cair da borda → troca direção
	if is_on_floor():
		var floor_dir = get_floor_normal()
		if floor_dir == Vector2.ZERO:
			_invert_state()

func _invert_state():
	state = State.WALK_LEFT if state == State.WALK_RIGHT else State.WALK_RIGHT


func _on_vital_area_body_entered(body):
	if body is Player:
		queue_free()
