extends Node

@onready var shoot_timer: Timer = %ShootTimer

@export var shoot_timeout: float = 3
@export var bullet_scene: PackedScene
@export_group("Parent Properties")
@export var parent_firer: Node2D
@export var parent_distance_buffer: float = 0.0


func _ready() -> void:
	shoot_timer.start(shoot_timeout)
	shoot_timer.timeout.connect(on_shoot_timeout)


func on_shoot_timeout():
	var bullet_instance = bullet_scene.instantiate() as Node2D
	get_tree().root.add_child(bullet_instance)
	bullet_instance.global_position = parent_firer.global_position + Vector2.DOWN * parent_distance_buffer
