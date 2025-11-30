extends CharacterBody2D

enum State { WALK_LEFT, WALK_RIGHT }
var state: State = State.WALK_RIGHT
@onready var collision_shape_2d = $CollisionShape2D
@onready var vital_collision = $VitalArea/VitalCollision
@onready var hit_collision = $HitCollision/HitCollision
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer


var speed := 60.0
var gravity := 900.0

func _ready():
	animated_sprite_2d.play("walk")

func _physics_process(delta):
	velocity.y += gravity * delta
	_process_state(delta)
	move_and_slide()

	_check_collision_and_flip()

func _process_state(_delta):
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
			animated_sprite_2d.flip_h = true
		else:
			state = State.WALK_RIGHT
			animated_sprite_2d.flip_h = false

	# (opcional) Se cair da borda → troca direção
	if is_on_floor():
		var floor_dir = get_floor_normal()
		if floor_dir == Vector2.ZERO:
			_invert_state()
		vital_collision.disabled = false
		hit_collision.disabled = false
	else:
		vital_collision.disabled = true
		hit_collision.disabled = true

func _invert_state():
	state = State.WALK_LEFT if state == State.WALK_RIGHT else State.WALK_RIGHT



func _on_vital_area_area_entered(area):
	if area.name == "FlipCollision":
		AudioController.play_alien_hurt()
		animation_player.play("death")
		

func die():
	Global.alien_count += 1
	queue_free()
	
