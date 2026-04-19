extends Node2D

var spawner : Node2D
var left_anchor : Marker2D 
var right_anchor : Marker2D 


var obstacles_speed: float = 60.0
const OBSTACLES_MIN_SPEED: float = 60.0
const OBSTACLES_MAX_SPEED: float = 100.0

const SCORE_UNTIL_MAX_SPEED:int = 10000

const TIME_BETWEEN_OBSTACLES = 1.0
const TIME_RANGE = 1.0


var time_until_next_left_obstacle := 100.0
var time_until_next_right_obstacle := 100.0
var right_strike := 0.0
var left_strike := 0.0

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
	var first_right = randf() > 0.5
	if first_right:
		time_until_next_right_obstacle = 0.0
		time_until_next_left_obstacle = TIME_BETWEEN_OBSTACLES/2 + randf() * TIME_RANGE
	else :
		time_until_next_left_obstacle = 0.0
		time_until_next_right_obstacle = TIME_BETWEEN_OBSTACLES/2 + randf() * TIME_RANGE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	time_until_next_left_obstacle -= delta
	time_until_next_right_obstacle -= delta
	
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
	obstacle.speed = obstacles_speed
	obstacle.position = left_anchor.position
	left_strike += 1.0
	right_strike = 0.0

func spawn_right_obstacle():
	var next_obstacle : Node2D = RIGHT_OBSTACLES_SCENES[randi_range(0,RIGHT_OBSTACLES_SCENES.size()-1)]
	var obstacle : Node2D = next_obstacle.duplicate()
	spawner.add_child(obstacle)
	obstacle.speed = obstacles_speed
	obstacle.position = right_anchor.position
	#var sprite2D: Sprite2D = obstacle.get_node("Sprite2D")
	#sprite2D.flip_h = true;
	right_strike += 1.0
	left_strike = 0.0
