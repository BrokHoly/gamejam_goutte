extends Node2D





func _ready() -> void:
	var score_made = GameManager.load_highest_score();

	if ( score_made == -1):
		return
	else:
		$HighestScore.text = str(score_made)


func _on_demarrer_pressed() -> void:
	GameManager.playerSkin = $SkinSelector/Skins/Sprite2D.texture
	get_tree().change_scene_to_file("res://levels/level_0.tscn")


func _on_quitter_pressed() -> void:
	get_tree().quit()
	




func _on_load_save_pressed() -> void:
	var result: int = GameManager.load_highest_score();
	print(result)
	


func _on_mode_coop_pressed() -> void:
	GameManager.number_of_player = 2
	GameManager.coop = true
	GameManager.playerSkin = load("res://Assets/Sprites/MainCharacter/GoutteNoOutline.png")
	get_tree().change_scene_to_file("res://menu/numberOfPlayerSelect.tscn")
