extends CharacterBody2D

const SPEED = 110.0
const JUMP_VELOCITY = -750
var health = 100

# collision shape variables
@onready var animatedsprite = $AnimatedSprite2D
@onready var jump_collision = $jump_CollisionShape2D
@onready var kick_punch_collision = $CollisionPolygon2D
@onready var idle_collision = $idle_CollisionShape2D

func _ready() -> void:
	add_to_group("player")

func take_damage(amount: int):
		health -= amount
		print(health)
		if health <= 0:
			queue_free()

# collision shape deactivation
func deactivate_collision():
	jump_collision.disabled = true
	kick_punch_collision.disabled = true
	idle_collision.disabled = true
# player movement animation and collision shape activation

func animated_movement():
	
	if not is_on_floor() and velocity.y > 0:
		if velocity.y < 0:
			animatedsprite.play("jump_up")
		elif velocity.y > 0:
			animatedsprite.play("jump_down")
		deactivate_collision()
		jump_collision.disabled = false
	if is_on_floor():
		if not Input.is_anything_pressed():
			animatedsprite.play("idle")
		deactivate_collision()
		idle_collision.disabled = false
	if Input.is_action_pressed("punch"):
		animatedsprite.play("punch")
		deactivate_collision()
		kick_punch_collision.disabled = false
		
	if Input.is_action_pressed("kick"):
		animatedsprite.play("kick")
		deactivate_collision()
		kick_punch_collision.disabled = false
		

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
		animatedsprite.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	animated_movement()
	move_and_slide()
