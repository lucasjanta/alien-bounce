extends Node2D

@export var mute : bool = false

func play_music():
	$MainMenu.stop()
	$Music.play()

func play_jump():
	$Jump.pitch_scale = randf_range(0.7, 1.2)
	$Jump.play()

func play_game_over():
	$GameOver.play()
	
func play_hurt():
	$Hurt.pitch_scale = randf_range(1.0, 1.4)
	$Hurt.play()
		
func play_alien_hurt():
	$AlienHurt.pitch_scale = randf_range(1.1, 1.5)
	$AlienHurt.play()
		
func play_get_points():
	$Point.play()

func play_death():
	$Death.play()

func play_button_hover():
	$ButtonHover.pitch_scale = randf_range(0.8, 1.4)
	$ButtonHover.play()

func play_main_memu_music():
	$Music.stop()
	$MainMenu.play()
