extends CharacterBody2D
class_name Player

## Max velocity of the player. Think about this as "top speed".
## Increase this to increase max speed, decrease to decrease max speed.
const MAX_VELOCITY = 300.0
## Acceleration applied when the player inputs a movement.
## Decrease the denomenator to "speed up faster", increase the denomenator to "speed up slower"
const ACCELERATION = MAX_VELOCITY / 3.0
## Friction applied every frame
## Decrease the denomenator to slow down faster, increase the denomenator to slow down slower
const FRICTION = MAX_VELOCITY / 10.0
## Friction, but only when the player is dead.
const DEATH_FRICTION = FRICTION / 3.0

const MAX_HORIZONTAL_LEAN = 25.
const HORIZONTAL_LEAN_ROTATIONAL_VELOCITY = 6.

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shoot_forward_bullet_component: ShootForwardBulletComponent = $ShootForwardBulletComponent
@onready var firing_cooldown: Timer = $FiringCooldown
@onready var visuals: Node2D = %Visuals

@onready var big_outer_explosion: GPUParticles2D = $BigOuterExplosion
@onready var small_inner_explosion: GPUParticles2D = $SmallInnerExplosion

@onready var shield: AnimatedSprite2D = %Shield
@onready var shield_hurtbox: Area2D = $ShieldHurtbox


var is_dead := false
var last_direction: Vector2 = Vector2.ZERO

var sprite_rotation_tween: Tween = null


func _ready() -> void:
	GameEvents.player_spawned.connect(on_player_spawn)
	shield_hurtbox.set_deferred("monitoring", false)
	shield.visible = false


func on_player_spawn() -> void:
	is_dead = false
	$Visuals.modulate = Color.WHITE

	# Show our sheild and block bullets
	shield_hurtbox.set_deferred("monitoring", true)
	shield.visible = true

	animation_player.play("invulnerability")
	await animation_player.animation_finished

	$HurtboxComponent.set_deferred("monitoring", true)
	# And don't forget to turn them off after!
	shield_hurtbox.set_deferred("monitoring", false)
	shield.visible = false


func _process(delta: float) -> void:
	if last_direction.x == 0:
		visuals.rotation = move_toward(visuals.rotation,\
			0,\
			HORIZONTAL_LEAN_ROTATIONAL_VELOCITY * delta)
	else:
		visuals.rotation = move_toward(visuals.rotation,\
			deg_to_rad(MAX_HORIZONTAL_LEAN) * sign(last_direction.x), \
			HORIZONTAL_LEAN_ROTATIONAL_VELOCITY * delta)


func _physics_process(delta: float) -> void:
	# Slow down with friction
	var active_friction: float
	if is_dead:
		active_friction = DEATH_FRICTION
	else:
		active_friction = FRICTION

	velocity.x = move_toward(velocity.x, 0, active_friction)
	velocity.y = move_toward(velocity.y, 0, active_friction)

	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if is_dead:
		direction = Vector2.ZERO

	if direction:
		# Speed up with acceleration
		velocity += direction * ACCELERATION
		velocity.x = clampf(velocity.x, -MAX_VELOCITY, MAX_VELOCITY)
		velocity.y = clampf(velocity.y, -MAX_VELOCITY, MAX_VELOCITY)

	move_and_slide()
	last_direction = direction


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
	$DeathSfx.play()
	animation_player.play("death")
	big_outer_explosion.emitting = true
	small_inner_explosion.emitting = true
	is_dead = true
	# Don't get hurt by bullets after we're dead
	$HurtboxComponent.set_deferred("monitoring", false)
	await big_outer_explosion.finished
	GameEvents.emit_player_died()
