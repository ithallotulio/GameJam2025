extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var player: CharacterBody2D = $"../Player"

func _ready() -> void:
	interactable.interact = _on_interact
	
func _on_interact():
	Gamedata.heat = player.heat
	Gamedata.stamina = player.stamina
	get_tree().change_scene_to_file("res://scenes/levels/fatec-interior/loja-habilidades.tscn")
