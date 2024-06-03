extends Node2D

@export var movement_component: Node


func _physics_process(delta: float) -> void:
	if !movement_component:
		return
	movement_component.move(self, delta)
