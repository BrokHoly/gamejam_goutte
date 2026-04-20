extends Node

var number_of_player : int = 1
var coop : bool = false
var playerThatDiedFirst : P = P.PLAYER1

enum P {PLAYER1, PLAYER2}
var player1_color : Color = Color("4995f3")#blue
var player2_color : Color = Color("e83b3b")#red



signal health_changed(amount: int)
signal health_changedP2(amount: int)
signal health_depleted(player : P)
signal health_depletedP2(player : P)
signal highest_score_changed()

signal score_boost_visual(amount : int)



const highest_score_str: String = "highest_score"
var highest_score : int = load_highest_score()


@onready var health: int = 3
@onready var healthP2: int = 3
@onready var score : int = 0
@onready var scoreP2 : int = 0
@onready var start_score: bool = false

var playerSkin : Resource

func _process(delta: float) -> void:
	if (start_score):
		score += 1
		if(coop):
			scoreP2 +=1
	
	

func _ready() -> void:
	health_changed.connect(health_changedyipi)
	health_changedP2.connect(health_changedP2Yipiiii)
	health_depleted.connect(reset_values)
	health_depletedP2.connect(reset_values)
	

	
func health_changedyipi(amount :int)->void:
	health += amount
	if(health == 0):
		health_depleted.emit(P.PLAYER1)
		
func health_changedP2Yipiiii(amount :int)->void:
	if(coop):
		healthP2 += amount
		if(healthP2 == 0):
			health_depletedP2.emit(P.PLAYER2)

	
	

func change_pitch(audio_player : AudioStreamPlayer2D)-> void:
	audio_player.pitch_scale = randf_range(0.8,1.2)

func change_pitch_and_play(audio_player : AudioStreamPlayer2D) -> void:
	audio_player.pitch_scale = randf_range(0.8,1.2)
	audio_player.play()


func reset_values(player : P) ->void:
	if(not coop):
		health = 3
		healthP2 = 3
		start_score = false
	
		if(score > load_highest_score()):
			save_highest_score(score)
			highest_score = score
			highest_score_changed.emit()
		get_tree().change_scene_to_file("res://menu/menu.tscn")

	else:
		playerThatDiedFirst = player
		health = 3
		healthP2 = 3
		start_score = false
		number_of_player = 2
		coop = true
		get_tree().change_scene_to_file("res://menu/end_menu_coop.tscn")
	
	
	

func save_highest_score(score : int) -> void:
	var save_file: FileAccess = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_dict: Dictionary[String, int] = {
		highest_score_str: score,
	}
	var json_string: String = JSON.stringify(save_dict)
	save_file.store_line(json_string)
	
func load_highest_score() -> int:
	if not FileAccess.file_exists("user://savegame.save"):
		return -1 # Error! We don't have a save to load.
		
	var save_file: FileAccess = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string: String = save_file.get_line()
		var json: JSON = JSON.new()
		var parse_result = json.parse(json_string)
		
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
			
		var node_data = json.data
		var found = node_data[highest_score_str]
		return found
		
	return -1


func reset_highest_score():
	#TODO reset highest score
	pass
