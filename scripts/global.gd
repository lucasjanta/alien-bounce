extends Node

const highscore_path : String = "user://highscore.txt"
var mobile_controls : bool = false
var alien_count : int = 0
var score : int = 0
var highscore : int = 0
var ui_label : Label
var hearts_animation : AnimatedSprite2D
var player : CharacterBody2D
var on_floor := true
var lifes : int = 3

func _ready():
	load_highscore()

func update_ui():
	ui_label.text = str(score)
	match lifes:
		3:
			hearts_animation.frame = 0
		2:
			hearts_animation.frame = 1
		1:
			hearts_animation.frame = 2
		0:
			hearts_animation.frame = 3

func reset():
	score = 0
	alien_count = 0
	lifes = 3
	on_floor = true
	update_ui()
	
func check_highscore() -> bool:
	if score > highscore:
		highscore = score
		save_highscore()
		return true
	else:
		return false
	

func load_highscore() -> int:
	var file : FileAccess = FileAccess.open(highscore_path, FileAccess.READ)
	if file:
		if file.get_length() > 0:
			highscore = file.get_as_text().to_int()
			file.close()
			return highscore
		else:
			print("Arquivo vazio")
			file.close()
			return 0
			
		
	else:
		print("N deu pra carregar")
		return 0
		
func save_highscore():
	var file : FileAccess = FileAccess.open(highscore_path, FileAccess.WRITE)
	if file:
		file.store_string(str(highscore))
		file.close()
	else:
		print("n foi possível acessar o arquivo")
