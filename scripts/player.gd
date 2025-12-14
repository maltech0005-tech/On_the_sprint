extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -450

@onready var animatedsprite = $AnimatedSprite2D

# player movement animation


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# get direction of player
	var direction := Input.get_axis("move_left", "move_right")
	
	# change player direction on key press
	if direction > 0:
		animatedsprite.flip_h = false
	elif direction < 0:
		animatedsprite.flip_h = true
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
