extends CharacterBody2D

const SIDE_SPEED: float = 70.0
const DOWN_SPEED: float = 20.0

enum STATES {LIQUID, ICE, SNOW}

var LIQUID_SKIN = load("res://Assets/Sprites/MainCharacter/GoutteNoOutline.png")
var ICE_SKIN = load("res://Assets/Sprites/MainCharacter/GoutteNoOutline.png")
var SNOW_SKIN = load("res://Assets/Sprites/MainCharacter/GoutteNoOutline.png")

var state = STATES.LIQUID
var sprite : Sprite2D


func _ready() -> void:
	sprite = $Sprite2D
	sprite.texture = LIQUID_SKIN




func _physics_process(delta: float) -> void:
	_handle_movements()
	_handle_inputs()


func _handle_movements():
	var side_direction := Input.get_axis("move_left", "move_right")
	var vert_direction := Input.get_axis("move_up","move_down")
	
	# Manage movements based on the drop state 
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
	if Input.is_action_just_pressed("toggle_ice"):
		_toggle_ice()
	if Input.is_action_just_pressed("toggle_snow"):
		_toggle_snow()


func _toggle_ice():
	if state == STATES.ICE:
		state = STATES.LIQUID
		sprite.texture = LIQUID_SKIN
	else:
		state = STATES.ICE
		sprite.texture = ICE_SKIN

func _toggle_snow():
	if state == STATES.SNOW:
		state = STATES.LIQUID
		sprite.texture = LIQUID_SKIN
	else:
		state = STATES.SNOW
		sprite.texture = SNOW_SKIN


func is_liquid() -> bool : 
	return state == STATES.LIQUID

func is_snow() -> bool : 
	return state == STATES.SNOW

func is_ice() -> bool : 
	return state == STATES.ICE
