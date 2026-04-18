extends Node2D

var spawner : Node2D
var left_anchor : Marker2D 
var right_anchor : Marker2D 

var OBSTACLES_SPEED: float = 70.0
const TIME_BETWEEN_OBSTACLES = 1.0
const TIME_RANGE = 1.0

var time_since_last_obstacle := 0.0
var time_since_left_obstacle := 0.0
var time_since_right_obstacle := 0.0

var time_until_next_obstacle := 0.0

var LEFT_OBSTACLES_SCENES : Array[Area2D] = [
	preload("res://props/leftleaf.tscn").instantiate()
]

var RIGHT_OBSTACLES_SCENES : Array[Area2D] = [
	preload("res://props/leftleaf.tscn").instantiate()
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawner = $ObstacleSpawner
	left_anchor = $ObstacleSpawner/LeftAnchor
	right_anchor = $ObstacleSpawner/RightAnchor
	# Instanciate Obstacles
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_since_last_obstacle += delta
	time_since_left_obstacle += delta
	time_since_right_obstacle += delta
	
	time_until_next_obstacle -= delta
	
	if time_since_last_obstacle > TIME_BETWEEN_OBSTACLES:
		print("SOON Obstacle")
		time_until_next_obstacle = randf() * TIME_RANGE
		time_since_last_obstacle = -time_until_next_obstacle
	
	if time_until_next_obstacle < 0.0 : 
		var go_right = randf() > 0.5
		if go_right:
			spawn_right_obstacle()
		else:
			spawn_left_obstacle()
		time_until_next_obstacle = 1000.0
	


func spawn_left_obstacle():
	var next_obstacle : Node2D = LEFT_OBSTACLES_SCENES[randi_range(0,LEFT_OBSTACLES_SCENES.size()-1)]
	var obstacle : Node2D = next_obstacle.duplicate()
	spawner.add_child(obstacle)
	obstacle.speed = OBSTACLES_SPEED
	obstacle.position = left_anchor.position
	time_since_last_obstacle = 0.0
	time_since_left_obstacle = 0.0
	pass

func spawn_right_obstacle():
	var next_obstacle : Node2D = RIGHT_OBSTACLES_SCENES[randi_range(0,RIGHT_OBSTACLES_SCENES.size()-1)]
	var obstacle : Node2D = next_obstacle.duplicate()
	spawner.add_child(obstacle)
	obstacle.speed = OBSTACLES_SPEED
	obstacle.position = right_anchor.position
	time_since_last_obstacle = 0.0
	time_since_right_obstacle = 0.0
	pass
