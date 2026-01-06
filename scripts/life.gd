extends Area2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var dropped = false
var collected = false
var added =false
var player=null
var direction: Vector2 = Vector2.ZERO
var life_icon_pos: Vector2
@onready var life_received: AudioStreamPlayer2D = $life_received

func _ready() -> void:
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
	
func _process(delta: float) -> void:
	if collected:
		position += direction * SPEED * delta
		if position<life_icon_pos:
			added = true
			player.gain_life(10)
			visible=false
			life_received.play()
			await life_received.finished
			queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		collected = true
