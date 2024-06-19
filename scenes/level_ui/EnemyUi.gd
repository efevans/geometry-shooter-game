extends Control

@onready var boss_name_label: Label = %BossNameLabel
@onready var boss_health_bar: ProgressBar = %BossHealthBar
@onready var boss_health_control: Control = %BossHealthControl

const MAX_WIDTH = 50

const SLIDE_IN_DURATION = 1.5
const HEALTH_BAR_INFLATE_DURATION = 1.4


var health_shake_tween: Tween


func _ready() -> void:
	GameEvents.boss_spawned.connect(on_boss_spawned)
	set.call_deferred("custom_minimum_size", Vector2(0, 0))
	boss_name_label.modulate = Color(1, 1, 1, 0)
	boss_health_bar.modulate = Color(1, 1, 1, 0)


func setup_ui() -> void:
	var slide_in_tween := create_tween()
	slide_in_tween.tween_property(self, "custom_minimum_size", Vector2(0, MAX_WIDTH), SLIDE_IN_DURATION)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	await slide_in_tween.finished

	var boss_name_tween := create_tween()
	boss_name_tween.tween_property(boss_name_label, "modulate:a", 1, 1)

	var inflate_health_bar_tween := create_tween()
	inflate_health_bar_tween.tween_property(boss_health_bar, "scale:x", 0, .01)
	inflate_health_bar_tween.tween_property(boss_health_bar, "modulate:a", 1, .01)
	inflate_health_bar_tween.tween_property(boss_health_bar, "scale:x", 1, HEALTH_BAR_INFLATE_DURATION)\
		.set_ease(Tween.EASE_OUT)


func setup_boss_health_monitoring(boss: Node2D) -> void:
	boss.health_changed.connect(on_boss_health_changed)


func on_boss_spawned(boss: Node2D) -> void:
	setup_ui()
	setup_boss_health_monitoring(boss)


func on_boss_health_changed(curr: int, total: int) -> void:
	boss_health_bar.value = float(curr) / total
	if health_shake_tween != null and health_shake_tween.is_running():
		return

	health_shake_tween = create_tween()
	health_shake_tween.tween_property(boss_health_control, "position:x", 4, .05)
	health_shake_tween.tween_property(boss_health_control, "position:x", -2, .05)
	health_shake_tween.tween_property(boss_health_control, "position:x", 3, .05)
	health_shake_tween.tween_property(boss_health_control, "position:x", -3, .05)
	health_shake_tween.tween_property(boss_health_control, "position:x", 0, .05)
