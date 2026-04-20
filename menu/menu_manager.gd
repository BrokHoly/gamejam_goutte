extends Node2D




var audioStream
func _ready() -> void:
	var score_made = GameManager.load_highest_score();
	audioStream = $AudioStreamPlayer2D
	if ( score_made == -1):
		return
	else:
		$HighestScore.text = str(score_made)




func _on_quitter_pressed() -> void:
	audioStream.play()
	get_tree().quit()
	




func _on_load_save_pressed() -> void:
	var result: int = GameManager.load_highest_score();
	print(result)
	



func _on_tuto_pressed() -> void:
	audioStream.play()
	GameManager.playerSkin = load("res://Assets/Sprites/MainCharacter/GoutteNoOutline.png")
	get_tree().change_scene_to_file("res://levels/tuto.tscn")


func _on_mode_coop_new_pressed() -> void:
	audioStream.play()
	GameManager.number_of_player = 2
	GameManager.coop = true
	GameManager.playerSkin = load("res://Assets/Sprites/MainCharacter/GoutteNoOutline.png")
	get_tree().change_scene_to_file("res://menu/numberOfPlayerSelect.tscn")


func _on_démarrer_pressed() -> void:
	var skin_s : SkinSelector = $SkinSelector
	audioStream.play()
	if(skin_s.skin_inventory[skin_s.selected].y == 1):
		GameManager.playerSkin = $SkinSelector/Skins/Sprite2D.texture
		get_tree().change_scene_to_file("res://levels/level_0.tscn")
	

#TODO changer ca un jour bref oé
func _on_démarrer_coop_end_menu_pressed() -> void:
	#Just to be sure everything will be okay after
	GameManager.reset_values(GameManager.P.PLAYER1)
	get_tree().change_scene_to_file("res://menu/menu.tscn")
