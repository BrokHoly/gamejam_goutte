extends Node2D

var spawner : Node2D
var left_anchor : Marker2D 
var right_anchor : Marker2D 

var OBSTACLES_SPEED: float = 70.0
const TIME_BETWEEN_OBSTACLES = 1.0
const TIME_RANGE = 1.0


var time_until_next_obstacle := 0.0
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
		load("res://props/leftleaf.tscn").instantiate()
	]
	LEFT_OBSTACLES_SCENES = [
		load("res://props/leftleaf.tscn").instantiate()
	]
	# Instanciate Obstacles
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	time_until_next_obstacle -= delta
	
	if time_until_next_obstacle < 0.0:
		#print("LeftStrike: ", left_strike, " RightStrike: ", right_strike)
		var go_right = randfn(-(right_strike/10.0)+(left_strike/10.0),1.0) > 0.0
		if go_right:
			spawn_right_obstacle()
		else:
			spawn_left_obstacle()
		time_until_next_obstacle = TIME_BETWEEN_OBSTACLES + randf() * TIME_RANGE
	


func spawn_left_obstacle():
	var next_obstacle : Node2D = LEFT_OBSTACLES_SCENES[randi_range(0,LEFT_OBSTACLES_SCENES.size()-1)]
	var obstacle : Node2D = next_obstacle.duplicate()
	spawner.add_child(obstacle)
	obstacle.speed = OBSTACLES_SPEED
	obstacle.position = left_anchor.position
	left_strike += 1.0
	right_strike = 0.0

func spawn_right_obstacle():
	var next_obstacle : Node2D = RIGHT_OBSTACLES_SCENES[randi_range(0,RIGHT_OBSTACLES_SCENES.size()-1)]
	var obstacle : Node2D = next_obstacle.duplicate()
	spawner.add_child(obstacle)
	obstacle.speed = OBSTACLES_SPEED
	obstacle.position = right_anchor.position
	right_strike += 1.0
	left_strike = 0.0
