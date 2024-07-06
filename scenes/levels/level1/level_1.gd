extends Node2D

@onready var enemy_spawner: Node = $EnemySpawner
@onready var boss_transition: CanvasLayer = $BossTransition

func _ready() -> void:
	MusicManager.play_song(MusicManager.SONG.LEVEL1)
	enemy_spawner.end_spawn.connect(start_boss_fight)
	GameEvents.boss_died.connect(on_boss_died)
	GameEvents.game_over.connect(on_player_died)


func start_boss_fight() -> void:
	boss_transition.play_transition()


func on_boss_died() -> void:
	MusicManager.play_song(MusicManager.SONG.VICTORY)


func on_player_died() -> void:
	MusicManager.play_song(MusicManager.SONG.DEFEAT)


