extends Node

const SAVE_PATH := "user://save_data.json"

var player_name := ""
var high_score := 0

func _ready():
	load_game()

func save_game():
	var data := {
		"player_name": player_name,
		"high_score": high_score
	}
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()

func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		return
		
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	
	if typeof(data) == TYPE_DICTIONARY:
		player_name = data.get("player_name","")
		high_score = data.get("high_score", 0)

func  set_high_score(score: int):
	if score > high_score:
		save_game()
