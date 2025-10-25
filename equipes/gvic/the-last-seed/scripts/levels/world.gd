extends Node2D


@onready var playerStatus = $Hud/PlayerStatus
@onready var player = $Player
@onready var entidade_ancestral: CharacterBody2D = $"Entidade Ancestral"
@onready var heat_filter: ColorRect = $Hud/HeatFilter
@onready var entidade_filter: ColorRect = $Hud/EntidadeFilter
@onready var plantable: TileMapLayer = $Level/Plantable


func _ready() -> void:
	# Entidade Spawn
	spawn_entidade()
	
	# Player Status
	player.heat = Gamedata.heat
	player.stamina = Gamedata.stamina
	playerStatus.updateStamina(player.stamina, player.max_stamina)
	playerStatus.updateHeat(player.heat, player.max_heat)


var tempo_proximo = 0.0

func _on_status_timer_timeout() -> void:
	player.heat += 0.75 + (Gamedata.world_hot_increase * Gamedata.day)
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
	var random_x = randi_range(-2112, 8320)
	var random_y = randi_range(-2304, 3520)
	var entidade_spawn_position = Vector2(random_x, random_y)
	
	while entidade_spawn_position.distance_to(player.global_position) < 1000:
		entidade_spawn_position = Vector2(randi_range(-2112, 8320), randi_range(-2304, 3520))
		
	entidade_ancestral.global_position = entidade_spawn_position
