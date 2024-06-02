extends Node2D

const SPEED: float = 60.0

@export var movement_component: Node


func _physics_process(delta: float) -> void:
	if !movement_component:
		return
	movement_component.move(self, SPEED * delta)
