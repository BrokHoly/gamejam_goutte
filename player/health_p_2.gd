extends TextureRect


var last_hp = GameManager.healthP2
func _ready() -> void:
	GameManager.health_changedP2.connect(take_damage)
	
	
func take_damage(amount : int) -> void :
	last_hp = GameManager.healthP2
	if(last_hp == 3):
		texture = load("res://Assets/UI/HPfulP2_1l1.png")
	elif (last_hp == 2):
		texture = load("res://Assets/UI/HPfulP2_1l2.png")
	elif(last_hp == 1):
		texture = load("res://Assets/UI/HPfulP2_1l3.png")
	elif(last_hp ==0 ):
		print("LE PERSONNAGE EST MORT")
	
