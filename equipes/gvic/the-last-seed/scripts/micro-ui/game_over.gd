extends Control

@onready var label_score: Label = $LabelScore
@onready var label_high_score: Label = $LabelHighScore
@onready var olhos: Sprite2D = $EntidadeAncestralOlhos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label_score.hide()
	label_high_score.hide()
	if Gamedata.score <= Gamedata.highscore:
		label_high_score.text = "Maior score: %d [%s]" % [Gamedata.highscore, Gamedata.highscore_player_name]
		label_score.text = "Seu score: %d" % [Gamedata.score]
	else:
		label_high_score.text = "Parabéns! Você conseguiu um novo recorde: %d" % [Gamedata.score]
		label_score.text = ""
	olhos.hide()
	await get_tree().create_timer(5.0).timeout
	label_score.show()
	label_high_score.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/world.tscn")


func _on_menu_pressed() -> void:
	get_tree().quit()


func toggle_visibility(sprite: Sprite2D):
	if sprite.visible:
		sprite.hide()
	else:
		sprite.show()


func _on_timer_timeout() -> void:
	var numero_piscadas = randi_range(0, 2)
	for i in range(numero_piscadas):
		toggle_visibility(olhos)
		await get_tree().create_timer(randf_range(0.01, 0.1)).timeout
		toggle_visibility(olhos)
		await get_tree().create_timer(randf_range(0.2, 0.8)).timeout
