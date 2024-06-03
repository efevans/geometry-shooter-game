extends Node

@onready var path_follow_2d: PathFollow2D = %PathFollow2D

@export var speed: float = 60.0

func move(object: Node2D, delta: float) -> void:
	var original_position := path_follow_2d.global_position
	path_follow_2d.progress += speed * delta
	object.global_position += path_follow_2d.global_position - original_position
