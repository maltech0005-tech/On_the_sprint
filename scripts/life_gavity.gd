extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var dropped = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if dropped:
		return
	if not dropped:
		if not is_on_floor():
			velocity += get_gravity() * delta
		else:
			dropped=true
			queue_free()
	move_and_slide()
