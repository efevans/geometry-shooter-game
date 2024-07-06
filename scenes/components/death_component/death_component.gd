extends Node2D

@export var health_component: HealthComponent
@export var stream: AudioStream
@export var sprite: Sprite2D
@export var animated_sprite: AnimatedSprite2D


func _ready() -> void:
	health_component.death.connect(on_death)
	$DeathSoundPlayer.stream = stream


#play death animation
#play death sfx
func on_death() -> void:
	if owner == null || not owner is Node2D:
		return

	if sprite:
		$DeadSprite.texture = sprite.texture
	elif animated_sprite:
		var animation: String = animated_sprite.animation
		var spriteFrames: SpriteFrames = animated_sprite.get_sprite_frames()
		var currentTexture: Texture2D = spriteFrames.get_frame_texture(animation, 0)
		$DeadSprite.texture = currentTexture

	var death_position: Vector2 = owner.global_position
	var death_manager: Node = get_tree().get_first_node_in_group("death_manager_layer")
	get_parent().remove_child(self)
	death_manager.add_child(self)

	visible = true
	global_position = death_position
	$DeathAnimation.play("death")
	$DeathSoundPlayer.play()

	# This does assume we're an enemy, but right now the player has custom death animation logic
	GameEvents.emit_enemy_died()
