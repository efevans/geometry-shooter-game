@tool
extends Marker2D

@onready var label: Label = %Label

@export var label_value: String:
	set(new_value):
		label_value = new_value
		%Label.text = new_value


func _ready() -> void:
	if !Engine.is_editor_hint():
		label.visible = false;


func get_path_2d() -> Path2D:
	return $Path2D
