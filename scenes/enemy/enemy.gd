extends Node2D

const SPEED = 2


func _physics_process(delta: float) -> void:
	global_position += Vector2.DOWN * SPEED
