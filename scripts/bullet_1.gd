extends Area2D

@export var speed := 300.0
@export var life_time := 2.0
@onready var sprite: AnimatedSprite2D = $bullet_sprite
@onready var life_timer: Timer = $lifetimer
var direction: Vector2 = Vector2.ZERO
var exploded := false

func _ready():
	life_timer.wait_time = life_time
	life_timer.start()

func _physics_process(delta):
	if exploded:
		return
	rotation = direction.angle()
	position += direction * speed * delta

func _on_body_entered(body):
	if exploded:
		return

	exploded = true
	speed = 0

	if body.is_in_group("player"):
		body.take_damage(10)

	sprite.play("explode")
	await sprite.animation_finished
	queue_free()

func _on_lifetimer_timeout():
	exploded = true
	speed = 0
	sprite.play("explode")
	await sprite.animation_finished
	queue_free()
