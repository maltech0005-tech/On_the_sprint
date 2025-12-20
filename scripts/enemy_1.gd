extends CharacterBody2D

@onready var timer = $Timer
@onready var detection_range = $detection_range
@onready var bullet = $bullet
@onready var bulllet_timer = $bullet/Timer
@onready var sprite = $AnimatedSprite2D2
@onready var bullet_sprite = $bullet/bullet_sprite
@onready var receive_damage = $receive_damage
@onready var player = $player

var health = 20
var direction = Vector2()
var projectile_speed = 120
var is_in_range = false
var attack_interval = 30

func _physics_process(delta: float) -> void:
	if is_in_range:
		bullet.global_position.x += projectile_speed*delta*-1
		sprite.flip_h=true
		bullet_sprite.flip_h=true
		
func _on_bullet_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		timer.start(attack_interval)
		bullet_sprite.play("explode")
		body.take_damage(10)
		bullet.global_position=global_position
		
	

func _on_detection_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_in_range = true
	
func _on_detection_range_body_exited(_body: Node2D) -> void:
	if bullet.global_position.x<global_position.x - 400:
		bullet.global_position=global_position
	timer.stop()
	
func _on_receive_damage_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		health -= 1
		if health >= 0:
			queue_free()
	
func _on_timer_timeout() -> void:
	if is_in_range:
		timer.start(attack_interval)
