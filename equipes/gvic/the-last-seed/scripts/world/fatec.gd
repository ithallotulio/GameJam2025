extends StaticBody2D

@onready var interactable: Area2D = $Interactable

var has_interacted = false

func _ready() -> void:
	interactable.interact = _on_interact
	
func _on_interact():
	get_tree().change_scene_to_file("res://scenes/levels/fatec_interior.tscn")
