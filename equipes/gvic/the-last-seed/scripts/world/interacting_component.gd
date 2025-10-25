extends Node2D

@onready var interact_label: Label = $InteractLabel
@onready var sprite: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var player: CharacterBody2D = $".."


var current_interactions := []
var can_interact := true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		if current_interactions:
			var target = current_interactions[0]
			var parent_body =  target.get_parent()
			can_interact = false
			interact_label.hide()
			
			# Fazer animação quando for plantar:
			if parent_body.name == "PlantableArea":
				if player.last_move_input == "move_right":
					sprite.play("plant-east")
				else:
					sprite.play("plant-west")
				await get_tree().create_timer(2.0).timeout
			
			await target.interact.call()
			
			can_interact = true


func _process(_delta: float) -> void:
	if current_interactions and can_interact:
		current_interactions.sort_custom(_sort_by_nearest)
		if current_interactions[0].is_interactable:
			interact_label.text = current_interactions[0].interact_name
			interact_label.show()
	else:
		interact_label.hide()


func _sort_by_nearest(area1, area2):
	var area1_dist = global_position.distance_to(area1.global_position)
	var area2_dist = global_position.distance_to(area2.global_position)
	return area1_dist < area2_dist


func _on_interact_range_area_entered(area: Area2D) -> void:
	current_interactions.push_back(area)


func _on_interact_range_area_exited(area: Area2D) -> void:
	current_interactions.erase(area)
