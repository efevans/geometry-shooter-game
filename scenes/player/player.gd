extends CharacterBody2D


const MAX_VELOCITY = 300.0
const ACCELERATION = MAX_VELOCITY / 3
const FRICTION = 35.0


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
