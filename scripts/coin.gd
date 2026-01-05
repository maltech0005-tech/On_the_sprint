extends Area2D

@export var speed := 300.0
var direction: Vector2 = Vector2.ZERO
var added := false
var player = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("coins")
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if added:
		return
	rotation = direction.angle()
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("coin_icon"):
		player.gain_coins(1)
		queue_free()
