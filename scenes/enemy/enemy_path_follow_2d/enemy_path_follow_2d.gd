extends PathFollow2D

var speed: float = 100.0


func _ready() -> void:
	get_child_speed()
	
	
func _physics_process(delta: float) -> void:
	progress += speed * delta


func get_child_speed() -> void:
	var child := get_children().front() as Node2D
	if !child:
		return
	if !child.get("speed"):
		return
	speed = child.speed
