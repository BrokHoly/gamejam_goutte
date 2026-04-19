extends CharacterBody2D

signal change_player_speed(playerID: int, bonus: float)

const SIDE_SPEED: float = 70.0
const DOWN_SPEED: float = 20.0
const ICE_DOWN_FLAT : float = 10.0
const ICE_SIDE_MULT : float = 0.8
const SNOW_DOWN_FLAT : float = -10.0
const SNOW_SIDE_MULT : float = 1.1

enum STATES {LIQUID, ICE, SNOW}
var LIQUID_SKIN : Resource

var LIQUID_SPRITE: Sprite2D
var ICE_SPRITE: Sprite2D
var SNOW_SPRITE: Sprite2D

var LIQUID_SHAPE: CollisionShape2D
var ICE_SHAPE: CollisionShape2D
var SNOW_SHAPE: CollisionShape2D	

const LIQUID_COLOR : Color = Color("4995f3")
const ICE_COLOR : Color = Color("8d9bc7cd")
const SNOW_COLOR : Color = Color("dfecfeff")

var DROP_PARTICULES: CPUParticles2D
var SPLASH_PARTICULES: CPUParticles2D

var state = STATES.LIQUID

var sprite : Sprite2D

const TRANSITION_TIME: float = 0.5
var transition_amout: float = 0.0
var baseColor: Color
var targetColor: Color

func _ready() -> void:
	LIQUID_SKIN = GameManager.playerSkin
	
	LIQUID_SHAPE = $LiquidCollision
	LIQUID_SHAPE = $IceCollision
	LIQUID_SHAPE = $SnowCollision
	
	LIQUID_SPRITE = $LiquidSprite
	ICE_SPRITE = $IceSprite
	SNOW_SPRITE = $SnowSprite
	
	LIQUID_SPRITE.texture = LIQUID_SKIN
	activate_liquid()
	
	
	baseColor = LIQUID_COLOR
	targetColor = LIQUID_COLOR
	
	DROP_PARTICULES = $DropParticules
	SPLASH_PARTICULES = $SplashParticules
	
	GameManager.health_changed.connect(take_damage)


func _physics_process(delta: float) -> void:
	_handle_movements()
	_handle_inputs()
	
func _process(delta: float) -> void:
	SNOW_SPRITE.rotation += 0.05
	if transition_amout <= TRANSITION_TIME:
		transition_amout += delta
		color_transition(baseColor, targetColor, transition_amout / TRANSITION_TIME)


func take_damage(amount : int):
	if(is_inside_tree()):
		var tweenRed = get_tree().create_tween()
		var tweenScale = get_tree().create_tween()

		var initial_color: Color = sprite.modulate;
		var initial_scale: Vector2 = scale
		
		$SplashParticules.emitting = true
		tweenRed.tween_property(sprite, "modulate", Color.RED, 0.25)
		tweenScale.tween_property(sprite, "scale", Vector2(1.25,1.25), 0.25)

		tweenScale.tween_property(sprite, "scale", initial_scale, 0.25)
		tweenRed.tween_property(sprite,"modulate",initial_color,0.25)




func _handle_movements():
	var side_direction := Input.get_axis("move_left", "move_right")
	var vert_direction := Input.get_axis("move_up","move_down")
	
	# Manage movements based on the drop state 
	if side_direction:
		velocity.x = side_direction * SIDE_SPEED
		if state == STATES.ICE:
			velocity.x *= ICE_SIDE_MULT
		if state == STATES.SNOW:
			velocity.x *= SNOW_SIDE_MULT
	else:
		velocity.x = move_toward(velocity.x, 0, SIDE_SPEED)
	if vert_direction:
		velocity.y = vert_direction * DOWN_SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, DOWN_SPEED)
	if state == STATES.ICE:
		velocity.y += ICE_DOWN_FLAT
	if state == STATES.SNOW:
		velocity.y += SNOW_DOWN_FLAT
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
		activate_liquid()
	else:
		GameManager.change_pitch_and_play($TransformIce)
		baseColor = targetColor
		targetColor = ICE_COLOR
		transition_amout = 0.0
		state = STATES.ICE
		sprite = ICE_SPRITE
		ICE_SPRITE.show()
		LIQUID_SPRITE.hide()
		SNOW_SPRITE.hide()
		# Shapes
		ICE_SPRITE.visible = true
		LIQUID_SHAPE.visible = false
		SNOW_SPRITE.visible = false
		if is_in_group("Player1"):
			emit_signal("change_player_speed",1, ICE_DOWN_FLAT)
			change_player_speed.emit(1, ICE_DOWN_FLAT)
		elif is_in_group("Player2"):
			emit_signal("change_player_speed",2, ICE_DOWN_FLAT)
			change_player_speed.emit(2, ICE_DOWN_FLAT)
		else:
			emit_signal("change_player_speed",0, ICE_DOWN_FLAT)
			change_player_speed.emit(0, ICE_DOWN_FLAT)
		

func _toggle_snow():
	if state == STATES.SNOW:
		activate_liquid()
		
	else:
		GameManager.change_pitch_and_play($TransformSnow)
		baseColor = targetColor
		targetColor = SNOW_COLOR
		transition_amout = 0.0
		state = STATES.SNOW
		SNOW_SPRITE.show()
		ICE_SPRITE.hide()
		LIQUID_SPRITE.hide()
		# Shapes
		SNOW_SPRITE.visible = true
		LIQUID_SHAPE.visible = false
		ICE_SPRITE.visible = false
		if is_in_group("Player1"):
			change_player_speed.emit(1, SNOW_DOWN_FLAT)
			emit_signal("change_player_speed",1, SNOW_DOWN_FLAT)
			
		elif is_in_group("Player2"):
			emit_signal("change_player_speed",0, SNOW_DOWN_FLAT)
			change_player_speed.emit(2, SNOW_DOWN_FLAT)
		else:
			emit_signal("change_player_speed",0, SNOW_DOWN_FLAT)
			change_player_speed.emit(0, SNOW_DOWN_FLAT)
		

func activate_liquid():
	GameManager.change_pitch_and_play($TranformLiquid)
	baseColor = targetColor
	targetColor = LIQUID_COLOR
	transition_amout = 0.0
	state = STATES.LIQUID
	sprite = LIQUID_SPRITE
	LIQUID_SPRITE.show()
	ICE_SPRITE.hide()
	SNOW_SPRITE.hide()
	# Shapes
	LIQUID_SHAPE.visible = true
	ICE_SPRITE.visible = false
	SNOW_SPRITE.visible = false
	if is_in_group("Player1"):
		emit_signal("change_player_speed",1, 1.0)
		change_player_speed.emit(1, 1.0)
	elif is_in_group("Player2"):
		emit_signal("change_player_speed",2, 1.0)
		change_player_speed.emit(2, 1.0)
	else:
		emit_signal("change_player_speed",0, 1.0)
		change_player_speed.emit(0, 1.0)
		
func is_liquid() -> bool : 
	return state == STATES.LIQUID

func is_snow() -> bool : 
	return state == STATES.SNOW

func is_ice() -> bool : 
	return state == STATES.ICE


func color_transition(baseColor: Color, targetColor:Color, amout: float):
	DROP_PARTICULES.color = baseColor.lerp(targetColor,amout)
	SPLASH_PARTICULES.color = baseColor.lerp(targetColor,amout)
