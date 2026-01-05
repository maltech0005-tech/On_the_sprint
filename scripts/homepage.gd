extends Node2D

@onready var play: Button = $VBoxContainer/play
@onready var help: Button = $VBoxContainer/help
@onready var settings: Button = $VBoxContainer/settings
@onready var help_tab: Node2D = $help_tab
@onready var exit_help: Button = $help_tab/exit_help
@onready var settings_tab: Node2D = $settings_tab
@onready var exit_settings: Button = $settings_tab/exit_settings
@onready var p_name: TextEdit = $settings_tab/p_name

func _ready() -> void:
	var music = $AudioStreamPlayer2D
	music.play()
	if Savemanager.player_name == "":
		pass
	else:
		p_name.text =Savemanager.player_name

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	
func _on_help_pressed() -> void:
	help_tab.visible=true
	
func _on_settings_pressed() -> void:
	settings_tab.visible=true

func _on_exit_help_pressed() -> void:
	help_tab.visible=false

func _on_exit_settings_pressed() -> void:
	settings_tab.visible=false

func _on_p_name_text_changed() -> void:
	Savemanager.player_name = $NameInput.text
	Savemanager.save_game()
