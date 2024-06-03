extends Node

func _ready() -> void:
	load_settings_from_disk()


## Load up our player settings
## MAKE SURE this funciton loads in the same order as we write
func load_settings_from_disk() -> void:
	var settings_file := FileAccess.open("user://settings.txt", FileAccess.READ)
	if settings_file == null:
		return

	settings_file.get_line()
	AudioServer.set_bus_volume_db(AudioConfig.MAIN_BUS_INDEX, linear_to_db(settings_file.get_line().to_float()))

	settings_file.get_line()
	AudioServer.set_bus_volume_db(AudioConfig.SFX_BUS_INDEX, linear_to_db(settings_file.get_line().to_float()))

	settings_file.get_line()
	AudioServer.set_bus_volume_db(AudioConfig.MUSIC_BUS_INDEX, linear_to_db(settings_file.get_line().to_float()))


## Save our player settings
## MAKE SURE this funciton writes in the same order as we read
func flush_settings_to_disk() -> void:
	var settings_file := FileAccess.open("user://settings.txt", FileAccess.WRITE)
	if settings_file == null:
		push_error("Settings file, created at user://settings.txt, was null. Not saving settings.")
		return

	settings_file.store_line("MainVolume")
	settings_file.store_line(str(db_to_linear(AudioServer.get_bus_volume_db(AudioConfig.MAIN_BUS_INDEX))))

	settings_file.store_line("SfxVolume")
	settings_file.store_line(str(db_to_linear(AudioServer.get_bus_volume_db(AudioConfig.SFX_BUS_INDEX))))

	settings_file.store_line("MusicVolume")
	settings_file.store_line(str(db_to_linear(AudioServer.get_bus_volume_db(AudioConfig.MUSIC_BUS_INDEX))))
