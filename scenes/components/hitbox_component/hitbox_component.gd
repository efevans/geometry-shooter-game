extends Area2D

signal hit()

## Function that should be invoked when the hitbox hits something
func on_hit() -> void:
	hit.emit()
