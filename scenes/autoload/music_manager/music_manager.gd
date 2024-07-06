extends AudioStreamPlayer

@onready var timer: Timer = $Timer

enum SONG {
	MENU = 0,
	MENU_INTRO = 1,
	LEVEL1 = 2,
	BOSS1 = 3,
	BOSS_INTRO = 4,
	VICTORY = 5,
	DEFEAT = 6
}

var song_list: Array[AudioStream]
var queued_song: SONG

func _ready() -> void:
	song_list.append_array([
		preload("res://scenes/main_menu/menu.mp3"),
		preload("res://scenes/main_menu/menu_intro.mp3"),
		preload("res://scenes/levels/level1/level_1.mp3"),
		preload("res://scenes/levels/level1/level_1_boss.mp3"),
		preload("res://scenes/boss_transition/boss_intro.mp3"),
		preload("res://scenes/levels/level1/level_1_victory.mp3"),
		preload("res://scenes/levels/level1/level_1_defeat.mp3")
	])
	timer.timeout.connect(on_delay_timeout)
	self.finished.connect(on_finished_playing)


func play_song(song: SONG) -> void:
	var new_song := song_list[song]

	# Don't do anything if we're trying to play the same song
	# Otherwise we'll get weird skipping artifacts
	if new_song == stream:
		return

	stream = new_song
	play()
	
	
func play_song_with_delay(song: SONG, delay:float) -> void:
	timer.stop()
	stop()
	queued_song = song
	timer.wait_time = delay
	timer.start()


func on_delay_timeout() -> void:
	play_song(queued_song)
	
func on_finished_playing() -> void:
	play()


