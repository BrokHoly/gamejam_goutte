extends Node2D


const highest_score: String = "highest_score"



func _on_demarrer_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_0.tscn")


func _on_quitter_pressed() -> void:
	get_tree().quit()
	
func save_highest_score(score : int) -> void:
	var save_file: FileAccess = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_dict: Dictionary[String, int] = {
		highest_score: score,
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
		var found = node_data[highest_score]
		return found
		
	return -1


func _on_debug_pressed() -> void:
	save_highest_score(100)
	


func _on_load_save_pressed() -> void:
	var result: int = load_highest_score();
	print(result)
	$HighestScore.text = result


func _on_mode_coop_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/numberOfPlayerSelect.tscn")
