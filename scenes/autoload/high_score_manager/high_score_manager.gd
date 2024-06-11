extends Node

const SCORE_FILENAME := "user://scores.dat"
const MAX_SCORE_COUNT = 10

var scores: Array


func _ready() -> void:
	load_scores_from_disk()
	GameEvents.score_set.connect(on_score_set)


## Load local high scores
## Scores are stored as an ordered array of 64 bit integers
## e.g. 
## [ 1000, 950, 800, ... ]
func load_scores_from_disk() -> void:
	var score_file := FileAccess.open(SCORE_FILENAME, FileAccess.READ)
	if score_file == null:
		scores = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
		print("missing high score file")
		return

	scores = JSON.parse_string(score_file.get_as_text()) as Array
	print("High scores")
	print(scores)


func flush_scores_to_disk() -> void:
	var score_file := FileAccess.open(SCORE_FILENAME, FileAccess.WRITE)
	if score_file == null:
		push_error("Score file, created at %s, was null. Not saving scores." % SCORE_FILENAME)
		return

	var save_data_str := JSON.stringify(scores)
	score_file.store_line(save_data_str)
	

func add_high_score(new_score: int) -> void:
	## Note: The scores array is a fixed size after calling load_scores_from_disk(),
	## so scores should be moved around by reassignment rather than push/pop
	for i in scores.size():
		if new_score > scores[i]:
			## push all worse scores back one, leaving the worst score off
			for j in range(scores.size() - 2, i - 1, -1):
				scores[j + 1] = scores[j]
			
			## add the new score at i
			scores[i] = new_score
			break
	

func on_score_set(score: int) -> void:
	add_high_score(score)
	flush_scores_to_disk()
