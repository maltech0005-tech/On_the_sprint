extends Area2D

var player =null

func _ready() -> void:
	add_to_group("life")
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
