extends Node2D
class_name Bullet

@export var movement_component: Node


func set_speed(speed: float) -> void:
	movement_component.speed = speed


func set_direction(direction: Vector2) -> void:
	movement_component.direction = direction
	rotation = direction.angle() - PI / 2


func set_is_from_player() -> void:
	$HitboxComponent.collision_layer = 1 << 0


func set_is_from_enemy() -> void:
	$HitboxComponent.collision_layer = 1 << 1


func _physics_process(delta: float) -> void:
	if !movement_component:
		return
	movement_component.move(self, delta)


func _on_hitbox_component_hit() -> void:
	queue_free()
