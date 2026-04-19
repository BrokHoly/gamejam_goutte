extends Node2D

var lab: Label
func _ready() -> void:
	GameManager.score_boost_visual.connect(start_little_animation)
	
	lab  = $"Score++"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func start_little_animation(scoreadded : int):
	var tweenScale = get_tree().create_tween()
	var tweenColor = get_tree().create_tween()
	var ancient_scale = scale
	var initial_color: Color = lab.modulate;

	
	tweenScale.tween_property(lab, "scale", ancient_scale + Vector2(0.5,0.5), 0.25)
	var random_color = Color(randf(), randf(), randf())
	tweenColor.tween_property(lab,"modulate", random_color, 0.25)
	tweenColor.tween_property(lab,"modulate", initial_color, 0.25)
	tweenScale.tween_property(lab, "scale", ancient_scale, 0.25)
	
	
	pass
