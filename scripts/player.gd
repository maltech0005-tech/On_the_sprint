extends CharacterBody2D

const SPEED = 110.0
const JUMP_VELOCITY = -500
var health = 100
var alive = true
var is_play=true

# collision shape variables
@onready var animatedsprite = $AnimatedSprite2D
@onready var jump_collision = $jump_CollisionShape2D
@onready var kick_punch_collision = $CollisionPolygon2D
@onready var idle_collision = $idle_CollisionShape2D
@onready var timer: Timer = $Timer
@onready var hp: TextureProgressBar = $Camera2D/HP
@onready var label: Label = $Camera2D/Label
@onready var pause: Button = $Camera2D/pause
@onready var score: Label = $Camera2D/score
@onready var coins: Label = $Camera2D/coins

func _ready() -> void:
	add_to_group("player")
	update_life_and_resources()
	label.text="HP"
	
func take_damage(amount: int):
	if health >= 0:
		health -= amount
		update_life_and_resources()
	else:
		alive=false

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
	if alive:
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
	else:
		animatedsprite.play("die")
		await animatedsprite.animation_finished
		timer.start(0.01)

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
	
func update_life_and_resources():
	hp.value=health
	


func _on_pause_pressed() -> void:
	if is_play:
		pause.icon=load("res://assets/Play Square Button.png")
		pause.text="play"
		is_play=false
		get_tree().paused = true
		
	else:
		pause.icon=load("res://assets/Pause Square Button.png")
		pause.text="pause"
		is_play=true
		get_tree().paused = false
