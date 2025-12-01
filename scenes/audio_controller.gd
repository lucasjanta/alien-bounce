extends Node2D

@export var mute : bool = false

func play_music():
	if not mute:
		$Music.play()

func play_jump():
	if not mute:
		$Jump.pitch_scale = randf_range(0.7, 1.2)
		$Jump.play()

func play_game_over():
	if not mute:
		$GameOver.play()
	
func play_hurt():
	if not mute:
		$Hurt.pitch_scale = randf_range(1.0, 1.4)
		$Hurt.play()
		
func play_alien_hurt():
	if not mute:
		$AlienHurt.pitch_scale = randf_range(1.1, 1.5)
		$AlienHurt.play()
		
func play_get_points():
	if not mute:
		$Point.play()

func play_death():
	if not mute:
		$Death.play()

func play_button_hover():
	if not mute:
		$ButtonHover.pitch_scale = randf_range(0.8, 1.4)
		$ButtonHover.play()
