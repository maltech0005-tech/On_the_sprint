extends Area2D

@export var speed := 300.0
var direction: Vector2 = Vector2.ZERO
var added := false
var player = null
var coin_icon_pos: Vector2 = Vector2.ZERO

@onready var coin_received: AudioStreamPlayer2D = $coin_received

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if added:
		return
	position += direction * speed * delta
	if position>coin_icon_pos:
		added = true
		player.gain_coin(1)
		visible=false
		coin_received.play()
		await coin_received.finished
		queue_free()
