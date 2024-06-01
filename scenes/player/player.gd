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


func _physics_process(delta: float) -> void:
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
