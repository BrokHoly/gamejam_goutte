extends Node2D



var skin_list : Array[Resource] = []
#Score , (index of skin, locked 0 or unlocked1)
var skin_inventory : Dictionary[int,Vector2] = {
	0:Vector2(0,0),
	1:Vector2(2000,1)
}

var selected : int = 0



func _ready() -> void:
	skin_list.append(load("res://Assets/Sprites/MainCharacter/GoutteNoOutline.png"))
	skin_list.append(load("res://Assets/Sprites/MainCharacter/Goutte.png"))
	GameManager.highest_score_changed.connect(new_highest_score)
	new_highest_score()
	
func new_highest_score() -> void:
	var score = GameManager.highest_score
	for i in skin_inventory:
		if(score > skin_inventory[i].x):
			skin_inventory[i] = Vector2(skin_inventory[i].x , 1)
		else:
			skin_inventory[i] = Vector2(skin_inventory[i].x , 0)



func _process(delta: float) -> void:
	$Skins/Sprite2D.texture = skin_list[selected]
	if(skin_inventory[selected].y == 0):
		$Skins/TextureRect.visible = true
		$Skins/Label.visible = true
		$Skins/Label.text = "Locked\n" +  str(skin_inventory[selected].x)
	else:
		$Skins/TextureRect.visible = false
		$Skins/Label.visible = false


func _on_arrow_left_pressed() -> void:
	$"../AudioStreamPlayer2D".play()
	if selected -1 >= 0:
		selected -= 1


func _on_arrow_right_pressed() -> void:
	$"../AudioStreamPlayer2D".play()
	if not(selected + 1 > skin_list.size()-1):
		selected += 1
	
