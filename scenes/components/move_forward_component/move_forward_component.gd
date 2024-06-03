extends Node

@export var speed: float = 60.0

func move(object: Node2D, delta: float) -> void:
	object.global_position += Vector2.DOWN * speed * delta
