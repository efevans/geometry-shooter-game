extends Node2D


@onready var main_volume: OptionsSlider = %MainVolume
@onready var sfx_volume: OptionsSlider = %SfxVolume
@onready var music_volume: OptionsSlider = %MusicVolume


func _ready() -> void:
	main_volume.update_value(db_to_linear(AudioServer.get_bus_volume_db(AudioConfig.MAIN_BUS_INDEX)))
	sfx_volume.update_value(db_to_linear(AudioServer.get_bus_volume_db(AudioConfig.SFX_BUS_INDEX)))
	music_volume.update_value(db_to_linear(AudioServer.get_bus_volume_db(AudioConfig.MUSIC_BUS_INDEX)))


func flush_settings_to_disk() -> void:
	SettingsManager.flush_settings_to_disk()


func _on_main_volume_value_change(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioConfig.MAIN_BUS_INDEX, linear_to_db(value / 100.0))


func _on_sfx_volume_value_change(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioConfig.SFX_BUS_INDEX, linear_to_db(value / 100.0))


func _on_music_volume_value_change(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioConfig.MUSIC_BUS_INDEX, linear_to_db(value / 100.0))
