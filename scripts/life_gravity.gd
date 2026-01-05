extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var drop_done =false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not drop_done:
		if not is_on_floor():
			velocity += get_gravity() * delta
	if is_on_floor():
		drop_done=true
		
	move_and_slide()
