extends Node

@export var speed: float = 100.0
@export var direction: Vector2 = Vector2.DOWN

func move(object: Node2D, delta: float) -> void:
	object.global_position += speed * direction * delta
