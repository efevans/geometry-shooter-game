extends CharacterBody2D


# Max velocity of the player. Think about this as "top speed".
# Increase this to increase max speed, decrease to decrease max speed.
const MAX_VELOCITY = 300.0
# Acceleration applied when the player inputs a movement.
# Decrease the denomenator to "speed up faster", increase the denomenator to "speed up slower"
const ACCELERATION = MAX_VELOCITY / 3.0
# Friction applied every frame
# Decrease the denomenator to slow down faster, increase the denomenator to slow down slower
const FRICTION = MAX_VELOCITY / 10.0


@onready var shoot_forward_bullet_component: ShootForwardBulletComponent = $ShootForwardBulletComponent
@onready var firing_cooldown: Timer = $FiringCooldown

@onready var big_outer_explosion: GPUParticles2D = $BigOuterExplosion
@onready var small_inner_explosion: GPUParticles2D = $SmallInnerExplosion


var is_dead := false


func _ready() -> void:
	big_outer_explosion.emitting = false
	big_outer_explosion.one_shot = true
	small_inner_explosion.emitting = false
	small_inner_explosion.one_shot = true


func _physics_process(delta: float) -> void:
	if is_dead:
		return

	# Slow down with friction
	velocity.x = move_toward(velocity.x, 0, FRICTION)
	velocity.y = move_toward(velocity.y, 0, FRICTION)

	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		# Speed up with acceleration
		velocity += direction * ACCELERATION
		velocity.x = clampf(velocity.x, -MAX_VELOCITY, MAX_VELOCITY)
		velocity.y = clampf(velocity.y, -MAX_VELOCITY, MAX_VELOCITY)

	move_and_slide()


func _unhandled_key_input(event: InputEvent) -> void:
	if is_dead:
		return

	if event.is_action_pressed("player_shoot"):
		if firing_cooldown.time_left > 0:
			return
		shoot_forward_bullet_component.fire_bullet()
		firing_cooldown.start()


func _on_firing_cooldown_timeout() -> void:
	if is_dead:
		return

	if Input.is_action_pressed("player_shoot"):
		shoot_forward_bullet_component.fire_bullet()
		firing_cooldown.start()


func _on_health_component_death() -> void:
	big_outer_explosion.emitting = true
	small_inner_explosion.emitting = true
	#$Visuals.visible = false
	var fade_tween := create_tween()
	fade_tween.tween_property($Visuals, "modulate", Color.TRANSPARENT, 1.0)
	is_dead = true
