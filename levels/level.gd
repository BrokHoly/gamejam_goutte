extends Node2D

var left_anchor : Marker2D 
var right_anchor : Marker2D 

var OBSTACLES_SPEED: float = 70.0
const RANDOM_RANGE: Vector2 = Vector2(1.0,3.0) #Seconds between each obstacles

var time_since_last_obstacle := 0.0
var time_since_left_obstacle := 0.0
var time_since_right_obstacle := 0.0

var LEFT_OBSTACLES_SCENES = [
	preload("res://props/leftleaf.tscn")
]

var RIGHT_OBSTACLES_SCENES = [
	preload("res://props/leftleaf.tscn")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	left_anchor = $ObstacleSpawner/LeftAnchor
	right_anchor = $ObstacleSpawner/RightAnchor
	# Instanciate Obstacles
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_since_last_obstacle += delta
	time_since_left_obstacle += delta
	time_since_right_obstacle += delta
	
	pass


func spawn_left_obstacle():
	pass
