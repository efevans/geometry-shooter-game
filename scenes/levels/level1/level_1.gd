extends Node2D

@onready var enemy_spawner: Node = $EnemySpawner
@onready var boss_transition: CanvasLayer = $BossTransition

func _ready() -> void:
	MusicManager.play_song(MusicManager.SONG.LEVEL1)
	enemy_spawner.end_spawn.connect(start_boss_fight)


func start_boss_fight() -> void:
	boss_transition.play_transition()

