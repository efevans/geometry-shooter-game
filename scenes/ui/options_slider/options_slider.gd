@tool
extends HBoxContainer
class_name OptionsSlider

signal ValueChange(value: float)
signal ValueDoneChanging()


@onready var label: Label = $Label
@onready var h_slider: HSlider = $HSlider
@onready var spin_box: SpinBox = $SpinBox


@export var label_name: String:
	set(value):
		$Label.text = value
		label_name = value


func _ready() -> void:
	label.text = label_name


func update_value(value: float) -> void:
	h_slider.value = value * 100.0
	spin_box.value = int(value * 100.0)


func _on_h_slider_value_changed(value: float) -> void:
	ValueChange.emit(value)
	spin_box.value = int(value)


func _on_h_slider_drag_ended(value_changed: bool) -> void:
	ValueDoneChanging.emit()


func _on_spin_box_value_changed(value: float) -> void:
	ValueChange.emit(value)
	ValueDoneChanging.emit()
	h_slider.value = value
