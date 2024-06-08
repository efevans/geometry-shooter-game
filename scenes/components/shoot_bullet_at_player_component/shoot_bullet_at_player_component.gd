extends Node

@onready var shoot_timer: Timer = %ShootTimer

@export var shoot_timeout: float = 3
@export var bullet_scene: PackedScene
@export_group("Parent Properties")
@export var parent_firer: Node2D
@export var parent_distance_buffer: float = 0.0
@export var stream: AudioStream


func _ready() -> void:
	shoot_timer.start(shoot_timeout)
	shoot_timer.timeout.connect(on_shoot_timeout)
	$ShootBulletPlayer.stream = stream


func on_shoot_timeout() -> void:
	var bullet_instance := bullet_scene.instantiate() as Bullet
	get_tree().root.add_child(bullet_instance)
	bullet_instance.global_position = parent_firer.global_position + Vector2.DOWN * parent_distance_buffer

	var player := get_tree().get_first_node_in_group("player") as Node2D
	if !player:
		return
	var normalized_direction_to_player := (player.global_position - bullet_instance.global_position).normalized()
	bullet_instance.set_direction(normalized_direction_to_player)

	# Bullets shot at the player are never from the player
	bullet_instance.set_is_from_enemy()

	$ShootBulletPlayer.play()
