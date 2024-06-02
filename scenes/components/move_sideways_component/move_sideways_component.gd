extends Node

@onready var path_follow_2d: PathFollow2D = %PathFollow2D


func move(object: Node2D, speed: float) -> void:
	var original_position := path_follow_2d.global_position
	path_follow_2d.progress += speed
	object.global_position += path_follow_2d.global_position - original_position
