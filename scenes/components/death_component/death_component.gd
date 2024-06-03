extends Node2D

@export var health_component: Node
@export var stream: AudioStream


func _ready() -> void:
	(health_component as HealthComponent).death.connect(on_death)
	$DeathSoundPlayer.stream = stream

#play death animation
#play death sfx
func on_death() -> void:
	if owner == null || not owner is Node2D:
		return
	$DeathSoundPlayer.play()

