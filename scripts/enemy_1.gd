extends CharacterBody2D

@export var bullet_scene: PackedScene
@export var fire_cooldown := 1.0

@onready var detection_range: Area2D = $detection_range
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var fire_timer: Timer = $firetimer
@onready var health_timer: Timer = $health_timer


var player: Node2D
var is_in_range := false
var health = 3

func _ready():
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
		
	fire_timer.wait_time = fire_cooldown
	

func _on_detection_range_body_entered(body):
	if body.is_in_group("player"):
		is_in_range = true
		fire_timer.start()

func _on_detection_range_body_exited(body):
	if body.is_in_group("player"):
		is_in_range = false
		fire_timer.stop()

func _on_firetimer_timeout():
	if not player or not is_in_range:
		return
	fire()

func fire():
	if bullet_scene == null:
		return
		
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)

	bullet.global_position = global_position

	var direction = (player.global_position - global_position).normalized()
	bullet.direction = direction

	sprite.flip_h = direction.x < 0
	
func _on_receive_damage_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if Input.is_action_pressed("punch") or Input.is_action_pressed("kick"):
			take_damage()

func _on_receive_damage_body_exited(_body: Node2D) -> void:
	pass # Replace with function body.
	
func take_damage():
	health_timer.start(1)
	
func _on_health_timer_timeout() -> void:
	health -= 1
	print("health")
	if health>=0:
		print("died")
		queue_free()
