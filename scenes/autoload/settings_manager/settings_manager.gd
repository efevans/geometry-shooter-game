extends Node

func _ready() -> void:
	load_settings_from_disk()


## Load up our player settings
## MAKE SURE this funciton loads in the same order as we write
## Dev note:
## This should batch up settings into groups of "versions"
## Each time you add something new, check if it exists first and if not, exit early
func load_settings_from_disk() -> void:
	var settings_file := FileAccess.open("user://settings.txt", FileAccess.READ)
	if settings_file == null:
		print("Settings file did not exist, loading no settings")
		return

	var things_loaded: Array[String] = []

	var main_bus_header := settings_file.get_line()
	if main_bus_header == "":
		print("Missing initial line of settings file, skipping remainig settings")
		print("Settings loaded: ", things_loaded)
		return
	things_loaded.append(main_bus_header)
	AudioServer.set_bus_volume_db(AudioConfig.MAIN_BUS_INDEX, linear_to_db(settings_file.get_line().to_float()))

	things_loaded.append(settings_file.get_line())
	AudioServer.set_bus_volume_db(AudioConfig.SFX_BUS_INDEX, linear_to_db(settings_file.get_line().to_float()))

	things_loaded.append(settings_file.get_line())
	AudioServer.set_bus_volume_db(AudioConfig.MUSIC_BUS_INDEX, linear_to_db(settings_file.get_line().to_float()))

	var locale_header := settings_file.get_line()
	if locale_header == "":
		print("Settings file was missing locale and thus v1, skipping remaining settings")
		print("Settings loaded: ", things_loaded)
		return
	things_loaded.append(locale_header)
	TranslationServer.set_locale(settings_file.get_line())


	# Add more settings loading above this point
	print("Settings loaded: ", things_loaded)


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

	settings_file.store_line("Locale")
	settings_file.store_line(TranslationServer.get_locale().split("_")[0])
