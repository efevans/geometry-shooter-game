extends Node2D

@onready var quit_button: Button = %QuitButton


func _ready() -> void:
	# Hide quitting for web (it doesn't do anything)
	if OS.has_feature("web"):
		quit_button.visible = false

	%PlayButton.grab_focus.call_deferred()


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level1/level_1.tscn")


func _on_high_score_button_pressed() -> void:
	print("TODO: Switch to high score scene")


func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings/settings.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
