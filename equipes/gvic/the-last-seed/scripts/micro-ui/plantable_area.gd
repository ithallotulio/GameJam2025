extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var sprite: Sprite2D = $Sprite2D
@onready var label: Label = $Label
@onready var player: CharacterBody2D = $"../Player"


func _ready() -> void:
	interactable.interact = _on_interact
	label.hide()
	if sprite.frame == 1:
		interactable.is_interactable = false


func _on_interact():
	interactable.is_interactable = false
	if plant():
		sprite.set_frame(1)
	else:
		label.show()
		await get_tree().create_timer(0.5).timeout
		label.hide()
		interactable.is_interactable = true

func plant():
	var random_number = randi_range(1, 100)
	var success = 50 + (Gamedata.plant_level * 10) - (Gamedata.score * 5)
	
	# Limita a chance de sucesso entre 20% e 80%s
	success = max(20, min(success, 80))
	print(success)
	if random_number <= success:
		return true
	return false
