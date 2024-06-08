extends Node


func get_enemy_layer() -> Node:
	return get_tree().get_first_node_in_group("enemy_layer")
