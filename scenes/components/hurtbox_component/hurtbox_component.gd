extends Area2D

@export var health_component: Node


func _ready() -> void:
	area_entered.connect(on_area_entered)


func take_damage() -> void:
	if !health_component:
		return
	health_component.hurt(1)


func on_area_entered(other_area: Area2D) -> void:
	take_damage()