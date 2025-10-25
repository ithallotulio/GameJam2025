extends Node2D

@onready var label_compra_efetuada: Label = $LabelCompraEfetuada
@onready var label_moedas: Label = $LabelMoedas
@onready var button_speed: Button = $buttonSpeed
@onready var button_heat: Button = $buttonHeat
@onready var button_plant: Button = $ButtonPlant


func _ready() -> void:
	label_compra_efetuada.hide()
	label_moedas.text = "Moedas: %d" % [Gamedata.moedas]
	button_speed.text = "Velocidade\nde movimento (%d)" % [Gamedata.speed_level]
	button_heat.text = "Resistência\nao calor (%d)" % [Gamedata.heat_level]
	button_plant.text = "Sucesso\nao plantar (%d)" % [Gamedata.plant_level]


func _on_buttonSpeed_pressed() -> void:
	if Gamedata.moedas >= 2:
		Gamedata.speed_level += 1
		Gamedata.moedas -= 2
		button_speed.text = "Velocidade\nde movimento (%d)" % [Gamedata.speed_level]
		label_moedas.text = "Moedas: %d" % [Gamedata.moedas]
		msg_compra_efetuada()

func _on_buttonHeat_pressed() -> void:
	if Gamedata.moedas >= 2:
		Gamedata.heat_level += 1
		Gamedata.moedas -= 2
		button_heat.text = "Resistência\nao calor (%d)" % [Gamedata.heat_level]
		label_moedas.text = "Moedas: %d" % [Gamedata.moedas]
		msg_compra_efetuada()

func _on_buttonPlant_pressed() -> void:
	if Gamedata.moedas >= 2:
		Gamedata.plant_level += 1
		Gamedata.moedas -= 2
		button_plant.text = "Sucesso\nao plantar (%d)" % [Gamedata.plant_level]
		label_moedas.text = "Moedas: %d" % [Gamedata.moedas]
		msg_compra_efetuada()


func _on_buttonBack_pressed() -> void:
	Gamedata.return_position = Vector2(128, 124)
	get_tree().change_scene_to_file("res://scenes/levels/fatec_interior.tscn")


func msg_compra_efetuada():
	label_compra_efetuada.show()
	await get_tree().create_timer(0.5).timeout
	label_compra_efetuada.hide()
