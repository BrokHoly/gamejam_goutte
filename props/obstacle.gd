extends Node2D

signal splash

var speed = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position.y < -30.0:
		queue_free()
	position.y -= speed * delta
	pass


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.is_ice() and is_in_group("breakable"):
			
			pass
		if body.is_liquid() and is_in_group("travesable"):
			# Add bonus point to Score
			pass 
		else :
			# Signal lose health point and maybe even score points ? 
			print("OUILLE")
			splash.emit()
			GameManager.health_changed.emit(-1)
	pass # Replace with function body.


func _on_spawn_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("invisible") and is_in_group("invincible"):
		# In taht case, we should stop the belower until it's out of range. 
		pass
		
	pass # Replace with function body.
