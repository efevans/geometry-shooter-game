extends Node
class_name ShootForwardBulletComponent

@onready var shoot_timer: Timer = %ShootTimer

@export var shoot_timeout: float = 3
@export var bullet_scene: PackedScene
@export var movement_direction := Vector2.DOWN
@export var bullet_speed: float = -1
@export_group("Parent Properties")
@export var parent_firer: Node2D
@export var parent_distance_buffer: float = 0.0
@export var parent_is_player := false
@export var stream: AudioStream


func _ready() -> void:
	if shoot_timeout > 0:
		shoot_timer.timeout.connect(on_shoot_timeout)
		shoot_timer.start(randf_range(0, shoot_timeout))
	$ShootBulletPlayer.stream = stream


func on_shoot_timeout() -> void:
	fire_bullet()
	shoot_timer.start(shoot_timeout)


func fire_bullet() -> void:
	var bullet_instance := bullet_scene.instantiate() as Bullet
	var bullet_layer := CommonObjects.get_bullet_layer()
	bullet_layer.add_child(bullet_instance)

	bullet_instance.set_direction(movement_direction)
	if bullet_speed != -1:
		bullet_instance.set_speed(bullet_speed)
	bullet_instance.global_position = parent_firer.global_position + movement_direction * parent_distance_buffer
	if parent_is_player:
		bullet_instance.set_is_from_player()
	else:
		bullet_instance.set_is_from_enemy()

	$ShootBulletPlayer.play()
