extends Node2D

const SPEED: float = 1.0
@export var movement_component: Node


func _physics_process(_delta: float) -> void:
	if !movement_component:
		return
	movement_component.move(self, SPEED)
