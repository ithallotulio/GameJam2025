extends Control

@onready var label_score: Label = $LabelScore
@onready var label_high_score: Label = $LabelHighScore
@onready var olhos: Sprite2D = $EntidadeAncestralOlhos
@onready var item_list: ItemList = $ItemList

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label_score.hide()
	label_high_score.hide()
	
	if Gamedata.score <= Gamedata.highscore:
		label_high_score.text = "Highscore: %d [%s]" % [Gamedata.highscore, Gamedata.highscore_player_name]
		label_score.text = "Score: %d" % [Gamedata.score]
	else:
		label_high_score.text = "Parabéns! Você conseguiu um novo recorde: %d" % [Gamedata.score]
		label_score.text = ""
		
	add_to_top_10(Gamedata.player_name, Gamedata.score)
	update_item_list()
		
	olhos.hide()
	label_score.show()
	label_high_score.show()


func update_item_list() -> void:
	item_list.clear()  # limpa itens antigos
	for entry in Gamedata.top_10:
		item_list.add_item("%s: %d" % [entry["name"], entry["score"]])


func add_to_top_10(player_name: String, score: int) -> void:
	var new_entry = {"name": player_name, "score": score}
	var found = false
	
	for i in range(Gamedata.top_10.size()):
		if Gamedata.top_10[i]["name"] == player_name:
			found = true
			if score > Gamedata.top_10[i]["score"]:
				Gamedata.top_10[i]["score"] = score
			break
	
	if not found:
		Gamedata.top_10.append(new_entry)
	
	Gamedata.top_10.sort_custom(func(a, b):
		return b["score"] - a["score"]
	)
	
	if Gamedata.top_10.size() > 10:
		Gamedata.top_10 = Gamedata.top_10.slice(0, 10)


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/world.tscn")


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/micro-ui/menu.tscn")


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
