extends TextureRect

var last_hp = GameManager.health
func _ready() -> void:
	GameManager.health_changed.connect(take_damage)
	
	
func take_damage(amount : int) -> void :
	last_hp = GameManager.health
	if(last_hp == 3):
		texture = load("res://Assets/UI/HPfull1.png")
	elif (last_hp == 2):
		texture = load("res://Assets/UI/HPfull2.png")
	elif(last_hp == 1):
		texture = load("res://Assets/UI/HPfull3.png")
	elif(last_hp ==0 ):
		print("LE PERSONNAGE EST MORT")
	
