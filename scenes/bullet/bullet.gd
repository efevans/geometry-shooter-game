extends Node2D
class_name Bullet

@export var movement_component: Node


func set_speed(speed: float) -> void:
	movement_component.speed = speed


func set_direction(direction: Vector2) -> void:
	movement_component.direction = direction
	rotation = direction.angle() - PI / 2


func _physics_process(delta: float) -> void:
	if !movement_component:
		return
	movement_component.move(self, delta)
