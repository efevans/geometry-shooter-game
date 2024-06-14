extends Node

@onready var scores_v_box_container: VBoxContainer = %ScoresVBoxContainer
@onready var button_click: AudioStreamPlayer2D = %ButtonClick
@onready var back_button: Button = %BackButton


func _ready() -> void:
	back_button.grab_focus.call_deferred()
	set_scores()
	
	
func set_scores() -> void:
	for existing_score: Node in scores_v_box_container.get_children():
		scores_v_box_container.remove_child(existing_score)
		existing_score.queue_free()
		
	for score : int in HighScoreManager.scores:
		var score_label := Label.new()
		score_label.text = str(score)
		scores_v_box_container.add_child(score_label)


func _on_back_button_pressed() -> void:
	button_click.play()
	await button_click.finished
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
