extends Node2D


@onready var playerStatus = $Hud/PlayerStatus
@onready var player = $Player
@onready var entidade_ancestral: CharacterBody2D = $"Entidade Ancestral"
@onready var heat_filter: ColorRect = $Hud/HeatFilter
@onready var entidade_filter: ColorRect = $Hud/EntidadeFilter
@onready var label: Label = $Hud/Label
@onready var label_day: Label = $LabelDay


func _ready() -> void:
	# Entidade Spawn
	spawn_entidade()
	
	# Sappling Load
	load_saplings()
	
	# Plantable Area Load or Spawn
	var plantaple_loaded = load_plantable_area()
	if !plantaple_loaded:
		spawn_plantable_area()
	
	# Player Status
	label.text = Gamedata.player_name
	player.heat = Gamedata.heat
	player.stamina = Gamedata.stamina
	playerStatus.updateStamina(player.stamina, player.max_stamina)
	playerStatus.updateHeat(player.heat, player.max_heat)
	
	# World Temperature
	var sapling_qty = len(Gamedata.sapling_list)
	var sapling_cool = sapling_qty * 0.05
	Gamedata.temp_celsius = 40 + 0.75 + (Gamedata.world_hot_increase * Gamedata.day) - sapling_cool
	
	# Label Day
	label_day.text = "Dia %d\n%.2fºC" % [Gamedata.day, Gamedata.temp_celsius]
	print(Gamedata.days_without_plant)
	
var tempo_proximo = 0.0

func _on_status_timer_timeout() -> void:
	player.heat += Gamedata.temp_celsius - 40
	playerStatus.updateStamina(player.stamina, player.max_stamina)
	playerStatus.updateHeat(player.heat, player.max_heat)
	var heat_level = float(player.heat) / player.max_heat
	if player.heat < player.max_heat:
		heat_filter.color = Color(255,0, 0, heat_level / 4)
	else:
		heat_filter.color = Color(255,0, 0, heat_level / 2)
	if player.heat > (player.max_heat * 1.2):
		player.game_over()
	
	var distancia_entidade = entidade_ancestral.global_position.distance_to(player.global_position)
	if distancia_entidade < 80:
		entidade_filter.color = Color(0, 0, 0, (0.5 - distancia_entidade / 200) + (tempo_proximo / 6))
		if tempo_proximo < 3:
			tempo_proximo += 0.2
	else:
		if distancia_entidade < 100:
			if tempo_proximo < 3:
				tempo_proximo += 0.1
			entidade_filter.color = Color(0, 0, 0, (0.5 - distancia_entidade / 200) + (tempo_proximo / 6))
		elif distancia_entidade > 150:
			if tempo_proximo >= 0:
				tempo_proximo -= max(0, tempo_proximo - 0.4)
			entidade_filter.color = Color(0, 0, 0,(tempo_proximo / 6))


func spawn_entidade():
	var random_x = randi_range(-2112, 3008)
	var random_y = randi_range(-1664, 2496)
	var entidade_spawn_position = Vector2(random_x, random_y)
	
	while entidade_spawn_position.distance_to(player.global_position) < 1000:
		entidade_spawn_position = Vector2(randi_range(-2112, 3008), randi_range(-1664, 2496))
		
	entidade_ancestral.global_position = entidade_spawn_position


var plantable: StaticBody2D;

func spawn_plantable_area():
	var random_x = randi_range(-2112, 3008)
	var random_y = randi_range(-1664, 2496)
	var plantable_area_spawn_position = Vector2(random_x, random_y)
	
	while plantable_area_spawn_position.distance_to(player.global_position) < 1000:
		plantable_area_spawn_position = Vector2(randi_range(-2112, 3008), randi_range(-1664, 2496))
	
	var plantable_area = preload("uid://drglsubbnxb5v").instantiate()
	
	add_child(plantable_area)
	plantable_area.position = plantable_area_spawn_position
	plantable = plantable_area

func load_plantable_area():
	if Gamedata.plantable_pos != Vector2i.ZERO:
		var plantable_area = preload("uid://drglsubbnxb5v").instantiate()
		add_child(plantable_area)
		plantable_area.position = Gamedata.plantable_pos
		plantable = plantable_area
		return true
	return false

func load_saplings():
	if Gamedata.sapling_list:
		for sapling_pos in Gamedata.sapling_list:
			var plantable_area = preload("uid://drglsubbnxb5v").instantiate()
			add_child(plantable_area)
			plantable_area.position = sapling_pos
			plantable_area.sapling()
			
