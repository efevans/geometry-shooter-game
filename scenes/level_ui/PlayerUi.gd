extends Control


@export var score := 0
@export_group("Score Modifications")
@export var enemy_death_score := 150

@onready var score_label: Label = $ScoreLabel


func _ready() -> void:
	GameEvents.enemy_died.connect(on_enemy_died)


func update_score_ui() -> void:
	score_label.text = "%08d" % score


func on_enemy_died() -> void:
	score += enemy_death_score
	update_score_ui()
