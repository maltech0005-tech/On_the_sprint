extends Area2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var player=null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]

func _on_body_entered(body: Node2D) -> void:
	pass
