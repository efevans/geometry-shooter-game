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
		
	var death_manager: Node 
	death_manager = get_tree().get_first_node_in_group("death_manager_layer")
	get_parent().remove_child(self)
	death_manager.add_child(self)
	
	$DeathSoundPlayer.play()

