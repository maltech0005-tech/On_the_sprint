extends Node2D

@export var background_scene: PackedScene
@export var enemy1: PackedScene
@onready var timer: Timer = $Timer

var player = null
var loopnumber: int = 1
var scenelength: int = 3024
var newscene = false
var pieces = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]

	var first_bgscene = background_scene.instantiate()
	first_bgscene.position = Vector2(0, 100)
	add_child(first_bgscene)
	pieces.append(first_bgscene)
	
	var second_bgscene = background_scene.instantiate()
	second_bgscene.position = Vector2(scenelength, 100)
	add_child(second_bgscene)
	pieces.append(second_bgscene)
	
	spawn_enemy()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (player.global_position.x+500) > scenelength*loopnumber:
		load_new_bg_scene()
		
func load_new_bg_scene():
	var new_piece = background_scene.instantiate()
	new_piece.position = Vector2(scenelength*loopnumber, 100)
	add_child(new_piece)
	pieces.append(new_piece)
	loopnumber += 1
	if player.global_position.x>(scenelength*(loopnumber-1)+500):
		pieces.pop_front()
		var first = pieces[0]
		first.queue_free()
		
func spawn_enemy():
	timer.start(8)

func _on_timer_timeout() -> void:
	var enemy=enemy1.instantiate()
	enemy.position=player.position+Vector2(200, 0)
	add_child(enemy)
	spawn_enemy()
