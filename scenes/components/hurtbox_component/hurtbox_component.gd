extends Area2D

@export var health_component: Node
@export var stream: AudioStream

func _ready() -> void:
	area_entered.connect(on_area_entered)
	$HurtSound.stream = stream


func take_damage() -> void:
	if !health_component:
		return
	if $HurtSound.stream:
		$HurtSound.play()
	health_component.hurt(1)


func on_area_entered(other_area: Area2D) -> void:
	take_damage()
	other_area.on_hit()
