extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var player: CharacterBody2D = $"../Player"
@onready var world: Node2D = $".."


func _ready() -> void:
	interactable.interact = _on_interact


func _on_interact():
	# Save Stamina e Heat
	Gamedata.stamina = player.stamina
	Gamedata.heat = player.heat
	
	# Save plantable
	if !world.plantable.is_planted(): # não plantou
		Gamedata.plantable_pos = world.plantable.position
		Gamedata.days_without_plant += 1
	else:
		Gamedata.sapling_list.append(world.plantable.position)
		Gamedata.plantable_pos = Vector2i.ZERO
		Gamedata.moedas += 1
	
	
	Gamedata.day += 1
	get_tree().change_scene_to_file("res://scenes/levels/fatec_interior.tscn")
