extends Node

## An enemy died somewhere
signal enemy_died()

func emit_enemy_died() -> void:
	enemy_died.emit()


## The player just died
signal player_died()

func emit_player_died() -> void:
	player_died.emit()


## The player needs to be spawned. This should trigger pre-spawn behaviors like
## animations, text pop ups, life icon removal, etc
signal player_needs_spawning()

func emit_player_needs_spawning() -> void:
	player_needs_spawning.emit()


## The player just spawned. This should trigger creation of the player
signal player_spawned()

func emit_player_spawned() -> void:
	player_spawned.emit()


## The player has no lives left, and died again.
## This should start the game over process
signal game_over()

func emit_game_over() -> void:
	game_over.emit()


## A new score was set
## This should be added to the high score list if it qualifies
signal score_set(score: int)

func emit_score_set(score: int) -> void:
	score_set.emit(score)
