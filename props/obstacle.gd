extends Node2D


var speed = 0.0
var audio_web_success : AudioStreamPlayer2D
var audio_leaf_success : AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_web_success = AudioStreamPlayer2D.new()
	audio_leaf_success = AudioStreamPlayer2D.new()
	audio_web_success.stream = load("res://Assets/Audio/web_succcess.mp3")
	audio_leaf_success.stream = load("res://Assets/Audio/leaf_success.mp3")
	add_child(audio_web_success)
	add_child(audio_leaf_success)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var areas = $SpawnBox.get_overlapping_areas()
	for area in areas:
		if area.is_in_group("invincible") :
			queue_free()
	if position.y < -30.0:
		queue_free()
	position.y -= speed * delta


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.is_in_group("Player1"):
			if body.is_ice() and is_in_group("breakable"):
				GameManager.score += 100
				audio_leaf_success.play()
				#TODO make an animation or something
				pass
			elif body.is_liquid() and is_in_group("traversable"):
				GameManager.score += 100
				audio_web_success.play()
				#TODO make an animation or something
				pass 
			else :
				# Signal lose health point and maybe even score points ? 
				GameManager.health_changed.emit(-1)
		elif(body.is_in_group("Player2")):
			if body.is_ice() and is_in_group("breakable"):
				GameManager.scoreP2 += 100
				#TODO make an animation or something
				pass
			elif body.is_liquid() and is_in_group("traversable"):
				GameManager.scoreP2 += 100
				#TODO make an animation or something
				pass 
			else :
				# Signal lose health point and maybe even score points ? 
				GameManager.health_changedP2.emit(-1)
			
	
	pass # Replace with function body.


func _on_spawn_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("invincible") and is_in_group("invincible"):
		var is_above = position.y > area.position.y
		if not is_above:
			queue_free()
		pass
		
	pass # Replace with function body.
