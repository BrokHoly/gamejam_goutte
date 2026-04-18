extends Area2D

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


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		# if...
		print("OUILLE")
		splash.emit()
		
	pass # Replace with function body.
