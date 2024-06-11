extends Control

@export_category("Score")
@export var score := 0
@export var enemy_death_score := 150

@export_category("Lives")
@export var lives_remaining := 0

@onready var score_label: Label = $ScoreLabel


func _ready() -> void:
	lives_remaining = $RemainingLives.get_child_count()
	GameEvents.enemy_died.connect(on_enemy_died)
	GameEvents.player_died.connect(on_player_died)


func update_score_ui() -> void:
	score_label.text = "%08d" % score


func on_enemy_died() -> void:
	score += enemy_death_score
	update_score_ui()


func on_player_died() -> void:
	lives_remaining -= 1

	if lives_remaining < 0:
		GameEvents.emit_game_over()
		GameEvents.emit_score_set(score)
	else:
		# index 0 is always safe to get (until we ran out of lives)
		$RemainingLives.get_child(0).queue_free()
		GameEvents.emit_player_needs_spawning()
