extends CharacterBody2D


const SIDE_SPEED = 70.0
const DOWN_SPEED = 20.0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	_handle_movements()
	_handle_inputs()


func _handle_movements():
	var side_direction := Input.get_axis("move_left", "move_right")
	var vert_direction := Input.get_axis("move_up","move_down")
	if side_direction:
		velocity.x = side_direction * SIDE_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SIDE_SPEED)
	if vert_direction:
		velocity.y = vert_direction * DOWN_SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, DOWN_SPEED)
	
	move_and_slide()
	pass


func _handle_inputs():
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		pass
	pass
