extends Node


func move(object: Node2D, speed: float) -> void:
	object.global_position += Vector2.DOWN * speed
