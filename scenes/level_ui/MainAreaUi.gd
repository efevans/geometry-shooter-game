extends Control


func _ready() -> void:
	GameEvents.player_needs_spawning.connect(on_player_needs_spawning)
	GameEvents.game_over.connect(on_game_over)


func on_player_needs_spawning() -> void:
	$AnimationPlayer.play("respawning")


func respawn_animation_done() -> void:
	GameEvents.emit_player_spawned()


func on_game_over() -> void:
	$AnimationPlayer.play("game_over")


func game_over_animation_done() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
