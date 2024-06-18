extends Node
class_name HealthComponent

signal health_changed(curr: int, total: int)
signal death

@export var skip_queue_free := false

@export var max_health: int = 1
var current_health: int = 0


func _ready() -> void:
	current_health = max_health


func hurt(damage: int) -> void:
	if !owner:
		return

	current_health -= damage
	health_changed.emit(current_health, max_health)
	if current_health <= 0:
		death.emit()
		if not skip_queue_free:
			owner.queue_free()
