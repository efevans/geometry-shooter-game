extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	pass


func play_transition() -> void:
	animation_player.play("warning")


func play_siren() -> void:
	MusicManager.play_song(MusicManager.SONG.BOSS_INTRO)
	

