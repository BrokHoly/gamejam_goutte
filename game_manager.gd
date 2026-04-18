extends Node

var number_of_player : int = 1




signal health_changed(amount: int)
signal health_depleted()
signal highest_score_changed()


const highest_score_str: String = "highest_score"
var highest_score : int = load_highest_score()


@onready var health: int = 3
@onready var score : int = 0
@onready var start_score: bool = false

var playerSkin : Resource

func _process(delta: float) -> void:
	if (start_score):
		score += 1
	

func _ready() -> void:
	health_changed.connect(health_changedyipi)
	health_depleted.connect(reset_values)

	
func health_changedyipi(amount :int)->void:
	health += amount
	if(health == 0):
		health_depleted.emit()

func reset_values() ->void:
	health = 3
	start_score = false
	if(score > load_highest_score()):
		save_highest_score(score)
		highest_score = score
		highest_score_changed.emit()
	
	score = 0
	
	get_tree().change_scene_to_file("res://menu/menu.tscn")

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
