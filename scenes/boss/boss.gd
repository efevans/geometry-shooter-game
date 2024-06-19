extends Node2D

signal health_changed(curr: int, total: int)

@onready var move_timer: Timer = %MoveTimer
@onready var health_component: HealthComponent = %HealthComponent

const MIN_HORIZONTAL_MOVEMENT_DISTANCE = 50
const MAX_HORIZONTAL_MOVEMENT_DISTANCE = 190

const MIN_VERTICAL_MOVEMENT_DISTANCE = 10
const MAX_VERTICAL_MOVEMENT_DISTANCE = 20

const LEFT_SIDE_POSITION_MIN = 50
const RIGHT_SIDE_POSITION_MAX = 400


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_timer.timeout.connect(on_move_timer_timeout)
	health_component.health_changed.connect(on_health_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func move() -> void:
	var horizontal_movement_direction := 1 if randi() % 2 == 0 else -1
	var horizontal_movement_distance := randi_range(MIN_HORIZONTAL_MOVEMENT_DISTANCE, MAX_HORIZONTAL_MOVEMENT_DISTANCE)

	var candidate_horizontal_end_position := global_position.x + horizontal_movement_direction * horizontal_movement_distance
	if candidate_horizontal_end_position < LEFT_SIDE_POSITION_MIN or candidate_horizontal_end_position > RIGHT_SIDE_POSITION_MAX:
		horizontal_movement_direction *= -1

	var vertical_movement_direction := 1 if randi() % 2 == 0 else -1
	var vertical_movement_distance := randi_range(MIN_VERTICAL_MOVEMENT_DISTANCE, MAX_VERTICAL_MOVEMENT_DISTANCE)

	var end_position := global_position + Vector2(\
		horizontal_movement_distance * horizontal_movement_direction,\
		vertical_movement_distance * vertical_movement_direction)

	var movement_tween := create_tween()
	movement_tween.tween_property(self, "global_position", end_position, 1.5)\
		.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)


func on_move_timer_timeout() -> void:
	move()


func on_health_changed(curr: int, total: int) -> void:
	health_changed.emit(curr, total)


func _on_health_component_death() -> void:
	GameEvents.emit_boss_died()
