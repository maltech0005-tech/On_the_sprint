extends Node2D

@export var background_scene: PackedScene
@export var enemy1: PackedScene
@export var enemy2: PackedScene
@export var enemy3: PackedScene
@export var enemy4: PackedScene
@export var coins: PackedScene
@export var life: PackedScene
@onready var timer: Timer = $Timer

var player = null
var coin_icon = null
var loopnumber: int = 1
var scenelength: int = 3024
var newscene = false
var pieces = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("game")
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
	coin_icon = get_tree().get_first_node_in_group("coin_icon")
	
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
	
func release_coin():
	var coin = coins.instantiate()
	if player.animatedsprite.flip_h==true:
		coin.position = player.position-Vector2(10, 30)
	else:
		coin.position = player.position+Vector2(10, 30)
	add_child(coin)
	var direction = (coin_icon.global_position - coin.position).normalized()
	coin.direction=direction

func _on_timer_timeout() -> void:
	var enemies=[]
	var enemy_1=enemy1.instantiate()
	var enemy_2=enemy2.instantiate()
	var enemy_3=enemy3.instantiate()
	var enemy_4=enemy4.instantiate()
	enemies.append(enemy_1)
	enemies.append(enemy_2)
	enemies.append(enemy_3)
	enemies.append(enemy_4)
	var enemy=enemies.pick_random()
	enemy.position=player.position+Vector2(200, 0)
	add_child(enemy)
	spawn_enemy()
