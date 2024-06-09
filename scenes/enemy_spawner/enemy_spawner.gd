extends Node

# Instructions for adding a new spawnable enemy type
# 1. Create a new enemy scene for that enemy
# 1.a	If you want the enemy to move along a track defined in this scene,
#		omit any movement logic in the enemy scene
# 1.b	If you want the enemy to move as defined by the enemy, define
#		that logic in the enemy scene
# 2.  Add a new preload in this scene for your enemy scene
#		e.g. var basic_enemy_scene: PackedScene = preload("res://scenes/enemy/enemy.tscn")
# 2. Add a new method named "spawn_<enemy_type>_at_position" with the argument "position: int"
#		e.g. "spawn_basic_enemy_at_position(position: int) -> void:"
# 3. In the method, instantiate the enemy scene, then call either add_enemy_to_position_path()
#		or move_enemy_to_position(). The former will have the enemy move along the path
#		and the latter will only move the enemy to the starting position
# 4. In the AnimationPlayer, use one of the method call tracks to spawn the enemies at your time.
#    Note: Any track can be used, the extra tracks exist to improve visibility of the timeline

@onready var positions: Array[Node2D] = [$"SpawnMarkers/1", $"SpawnMarkers/2", $"SpawnMarkers/3", $"SpawnMarkers/4", $"SpawnMarkers/5", $"SpawnMarkers/6", $"SpawnMarkers/7", $"SpawnMarkers/8", $"SpawnMarkers/9", $"SpawnMarkers/10", $"SpawnMarkers/11", $"SpawnMarkers/12", $"SpawnMarkers/13", $"SpawnMarkers/14", $"SpawnMarkers/15"]
@export var enemy_path_follow_2d: PackedScene

var basic_enemy_scene: PackedScene = preload("res://scenes/enemy/enemy.tscn")
var move_forward_enemy_scene: PackedScene = preload("res://scenes/enemy/move_forward_enemy/move_forward_enemy.tscn")
var shoot_bullet_enemy_scene: PackedScene = preload("res://scenes/enemy/shoot_bullet_enemy/shoot_bullet_enemy.tscn")


func spawn_basic_enemy_at_position(position: int) -> void:
	var enemy_instance := basic_enemy_scene.instantiate() as Node2D
	add_enemy_to_position_path(enemy_instance, position)


func spawn_move_forward_enemy_at_position(position: int) -> void:
	var enemy_instance := move_forward_enemy_scene.instantiate() as Node2D
	move_enemy_to_position(enemy_instance, position)


func spawn_shoot_forward_enemy_at_position(position: int) -> void:
	var enemy_instance := shoot_bullet_enemy_scene.instantiate() as Node2D
	add_enemy_to_position_path(enemy_instance, position)
	

func add_enemy_to_position_path(enemy_instance: Node2D, position: int) -> void:
	var path_follow_2d_instance := enemy_path_follow_2d.instantiate() as Node2D
	path_follow_2d_instance.add_child(enemy_instance)

	var position_node := get_position_node(position) as Node2D
	var position_path_node := position_node.get_path_2d() as Path2D
	position_path_node.add_child(path_follow_2d_instance)


func move_enemy_to_position(enemy_instance: Node2D, position: int) -> void:
	var enemy_layer := CommonObjects.get_enemy_layer()
	if !enemy_layer:
		enemy_layer = get_tree().root
	enemy_layer.add_child(enemy_instance)

	var position_node := get_position_node(position) as Node2D
	enemy_instance.global_position = position_node.global_position


func get_position_node(position: int) -> Node2D:
	return positions[position - 1]
