extends Area2D


var player =null

func _ready() -> void:
	add_to_group("coin_icon")
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_coin_icon_body_entered(body: Node2D) -> void:
	if body.is_in_group("coins"):
		player.gain_coin(1)
