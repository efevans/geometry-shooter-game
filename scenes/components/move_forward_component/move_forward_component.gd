extends Node


func move(object: Node2D, speed: float):
	object.global_position += Vector2.DOWN * speed
