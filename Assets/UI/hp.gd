extends TextureRect



func take_damage(number_of_hp: int) -> void :
	if(number_of_hp == 3):
		texture = load("res://Assets/UI/HPfull1.png")
	elif (number_of_hp == 2):
		texture = load("res://Assets/UI/HPfull2.png")
	elif(number_of_hp == 1):
		texture = load("res://Assets/UI/HPfull3.png")
	elif(number_of_hp ==0 ):
		print("LE PERSONNAGE EST MORT")
	
	
	pass
