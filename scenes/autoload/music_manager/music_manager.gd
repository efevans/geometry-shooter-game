extends AudioStreamPlayer

enum SONG {
	MENU = 0,
	MENU_INTRO = 1,
	LEVEL1 = 2,
	BOSS1 = 3
}


var song_list: Array[AudioStream]

func _ready() -> void:
	song_list.append_array([
		preload("res://scenes/main_menu/menu.mp3"),
		preload("res://scenes/main_menu/menu_intro.mp3"),
		preload("res://scenes/levels/level1/level_1.mp3"),
		preload("res://scenes/levels/level1/level_1_boss.mp3")
	])


func play_song(song: SONG) -> void:
	var new_song := song_list[song]

	# Don't do anything if we're trying to play the same song
	# Otherwise we'll get weird skipping artifacts
	if new_song == stream:
		return

	stream = new_song
	play()



