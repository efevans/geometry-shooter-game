extends Node2D


@onready var main_volume: OptionsSlider = %MainVolume
@onready var sfx_volume: OptionsSlider = %SfxVolume
@onready var music_volume: OptionsSlider = %MusicVolume
@onready var locale_selector: OptionButton = %LocaleSelector

const locale_by_index := [
	"en", "ja"
]


func _ready() -> void:
	main_volume.update_value(db_to_linear(AudioServer.get_bus_volume_db(AudioConfig.MAIN_BUS_INDEX)))
	sfx_volume.update_value(db_to_linear(AudioServer.get_bus_volume_db(AudioConfig.SFX_BUS_INDEX)))
	music_volume.update_value(db_to_linear(AudioServer.get_bus_volume_db(AudioConfig.MUSIC_BUS_INDEX)))

	var current_locale_code := TranslationServer.get_locale().split("_")[0]
	var current_locale_index := locale_by_index.find(current_locale_code)
	locale_selector.select(current_locale_index)


func flush_settings_to_disk() -> void:
	SettingsManager.flush_settings_to_disk()


func _on_main_volume_value_change(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioConfig.MAIN_BUS_INDEX, linear_to_db(value / 100.0))


func _on_sfx_volume_value_change(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioConfig.SFX_BUS_INDEX, linear_to_db(value / 100.0))


func _on_music_volume_value_change(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioConfig.MUSIC_BUS_INDEX, linear_to_db(value / 100.0))


func _on_back_button_pressed() -> void:
	$ButtonClick.play()
	await $ButtonClick.finished
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")


func _on_locale_selector_item_selected(index: int) -> void:
	TranslationServer.set_locale(locale_by_index[index])
	flush_settings_to_disk()
