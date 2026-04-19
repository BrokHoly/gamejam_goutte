extends Node2D

signal change_player_speed(playerID: int, bonus: float)

var spawner : Node2D
var left_anchor : Marker2D 
var right_anchor : Marker2D 

var current_obstacles_speed: float
var OBSTACLES_MIN_SPEED: float = 60.0
var OBSTACLES_MAX_SPEED: float = 110.0
var last_bonus_players: Array[float]

const SCORE_UNTIL_MAX_SPEED:int = 10000

const BEGIN_TIME_BETWEEN_OBSTACLES = 2.0
const END_TIME_BETWEEN_OBSTACLES = 2.0

const TIME_BETWEEN_OBSTACLES = 2.0
const TIME_RANGE = 1.0


var time_until_next_left_obstacle := 100.0
var time_until_next_right_obstacle := 100.0

var LEFT_OBSTACLES_SCENES : Array[Node2D]
var RIGHT_OBSTACLES_SCENES : Array[Node2D] 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawner = $ObstacleSpawner
	left_anchor = $ObstacleSpawner/LeftAnchor
	right_anchor = $ObstacleSpawner/RightAnchor
	
	RIGHT_OBSTACLES_SCENES = [
		load("res://props/leaf_right.tscn").instantiate(),
		load("res://props/web_right.tscn").instantiate(),
		load("res://props/branch_right.tscn").instantiate(),
	]
	LEFT_OBSTACLES_SCENES = [
		load("res://props/leaf_left.tscn").instantiate(),
		load("res://props/web_left.tscn").instantiate(),
		load("res://props/branch_left.tscn").instantiate(),
	]
	# Instanciate Obstacles
	GameManager.start_score = true
	_prepare_players_arrays()
	last_bonus_players.set(0,1.0)
	var first_right = randf() > 0.5
	if first_right:
		time_until_next_right_obstacle = 0.0
		time_until_next_left_obstacle = TIME_BETWEEN_OBSTACLES/2 + randf() * TIME_RANGE
	else :
		time_until_next_left_obstacle = 0.0
		time_until_next_right_obstacle = TIME_BETWEEN_OBSTACLES/2 + randf() * TIME_RANGE
	
	change_player_speed.connect(updateObstaclesSpeed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	time_until_next_left_obstacle -= delta
	time_until_next_right_obstacle -= delta
	
	current_obstacles_speed = minf(OBSTACLES_MIN_SPEED + ((float(GameManager.score) / SCORE_UNTIL_MAX_SPEED) * (OBSTACLES_MAX_SPEED - OBSTACLES_MIN_SPEED)),OBSTACLES_MAX_SPEED)
	print(current_obstacles_speed)
	if time_until_next_right_obstacle < 0.0:
		spawn_right_obstacle()
		time_until_next_right_obstacle = TIME_BETWEEN_OBSTACLES + randf() * TIME_RANGE
		#print("LeftStrike: ", left_strike, " RightStrike: ", right_strike)
		#var go_right = randfn(-(right_strike/10.0)+(left_strike/10.0),1.0) > 0.0
	if time_until_next_left_obstacle < 0.0:
		spawn_left_obstacle()
		time_until_next_left_obstacle = TIME_BETWEEN_OBSTACLES + randf() * TIME_RANGE


func spawn_left_obstacle():
	var next_obstacle : Node2D = LEFT_OBSTACLES_SCENES[randi_range(0,LEFT_OBSTACLES_SCENES.size()-1)]
	var obstacle : Node2D = next_obstacle.duplicate()
	spawner.add_child(obstacle)
	obstacle.speed = current_obstacles_speed
	obstacle.position = left_anchor.position
	#left_strike += 1.0
	#right_strike = 0.0

func spawn_right_obstacle():
	var next_obstacle : Node2D = RIGHT_OBSTACLES_SCENES[randi_range(0,RIGHT_OBSTACLES_SCENES.size()-1)]
	var obstacle : Node2D = next_obstacle.duplicate()
	spawner.add_child(obstacle)
	obstacle.speed = current_obstacles_speed
	obstacle.position = right_anchor.position
	#var sprite2D: Sprite2D = obstacle.get_node("Sprite2D")
	#sprite2D.flip_h = true;
	#right_strike += 1.0
	#left_strike = 0.0

func _prepare_players_arrays():
	for i in GameManager.number_of_player:
		last_bonus_players.append(1.0)

func updateObstaclesSpeed(player: int, bonus: float):
	if GameManager.coop:
		for i in range(last_bonus_players):
			if bonus > last_bonus_players[i]:
				OBSTACLES_MIN_SPEED = 60.0 * bonus
				OBSTACLES_MAX_SPEED = 110.0 * bonus
				last_bonus_players[i] = bonus
	else:
		if bonus > last_bonus_players[0]:
			OBSTACLES_MIN_SPEED = 60.0 * bonus
			OBSTACLES_MAX_SPEED = 110.0 * bonus
			print(OBSTACLES_MIN_SPEED)
			last_bonus_players[0] = bonus
		
		
	 
