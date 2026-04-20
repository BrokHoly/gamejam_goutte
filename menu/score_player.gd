extends Node2D


func _ready() -> void:
	
	if(GameManager.playerThatDiedFirst == GameManager.P.PLAYER2):
		$HighestScore4.text = str(int(GameManager.scoreP2 * 0.8)) 
		$HighestScore3.text = str(GameManager.score)
		if(GameManager.scoreP2 * 0.8 >GameManager.score):
			
			$HighestScore5.add_theme_color_override("font_color",GameManager.player2_color)
			$HighestScore5.text = "PLAYER 2 WIN"
		else:
			$HighestScore5.add_theme_color_override("font_color", GameManager.player1_color)
			$HighestScore5.text = "PLAYER 1 WIN"
	elif(GameManager.playerThatDiedFirst == GameManager.P.PLAYER1):
		$HighestScore3.text = str(int(GameManager.score * 0.8))
		$HighestScore4.text = str(GameManager.scoreP2)
		if(GameManager.scoreP2 > GameManager.score * 0.8):
			$HighestScore5.add_theme_color_override("font_color", GameManager.player2_color)
			$HighestScore5.text = "PLAYER 2 WIN"
		else:
			$HighestScore5.add_theme_color_override("font_color",GameManager.player1_color)
			$HighestScore5.text = "PLAYER 1 WIN"
		

	
	
