extends Node

@onready var scores_v_box_container: VBoxContainer = %ScoresVBoxContainer


func _ready() -> void:
	set_scores()
	
	
func set_scores() -> void:
	for existing_score: Node in scores_v_box_container.get_children():
		scores_v_box_container.remove_child(existing_score)
		existing_score.queue_free()
		
	for score : int in HighScoreManager.scores:
		var score_label := Label.new()
		score_label.text = str(score)
		scores_v_box_container.add_child(score_label)
