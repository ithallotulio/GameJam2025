extends Control

@onready var line_edit: LineEdit = $VBoxContainer/HBoxContainer/LineEdit
@onready var error_label: Label = $ErrorLabel

func _ready() -> void:
	error_label.hide()

func _on_button_pressed() -> void:
	var input = line_edit.text.strip_edges() 
	
	if input != "" and line_edit.text not in Gamedata.all_players: 
		Gamedata.player_name = line_edit.text
		Gamedata.all_players.append(line_edit.text)
		get_tree().change_scene_to_file("res://scenes/levels/world.tscn") 
	else:
		error_label.show()
		await get_tree().create_timer(2.0).timeout
		error_label.hide()
