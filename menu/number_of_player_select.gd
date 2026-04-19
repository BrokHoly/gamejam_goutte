extends Node2D


func _on_demarrer_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_0_coop.tscn")
