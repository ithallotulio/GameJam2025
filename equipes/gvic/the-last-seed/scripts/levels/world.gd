extends Node2D


@onready var playerStatus = $Hud/PlayerStatus
@onready var player = $Player
@onready var entidade_ancestral: CharacterBody2D = $"Entidade Ancestral"
@onready var heat_filter: ColorRect = $Hud/HeatFilter
@onready var entidade_filter: ColorRect = $Hud/EntidadeFilter


func _ready() -> void:
	spawn_entidade()
	player.heat = Gamedata.heat
	player.stamina = Gamedata.stamina
	playerStatus.updateStamina(player.stamina, player.max_stamina)
	playerStatus.updateHeat(player.heat, player.max_heat)


func _on_status_timer_timeout() -> void:
	player.heat += 0.75
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
	if distancia_entidade < 50:
		entidade_filter.color = Color(0, 0, 0, 0.9)
	else:
		if distancia_entidade < 80:
			entidade_filter.color = Color(0, 0, 0, 0.5 - distancia_entidade / 625)
		elif distancia_entidade > 120:
			entidade_filter.color = Color(0, 0, 0, 0)


func spawn_entidade():
	var random_x = randi_range(-2112, 8320)
	var random_y = randi_range(-2304, 3520)
	var entidade_spawn_position = Vector2(random_x, random_y)
	
	while entidade_spawn_position.distance_to(player.global_position) < 1000:
		entidade_spawn_position = Vector2(randi_range(-2112, 8320), randi_range(-2304, 3520))
		
	entidade_ancestral.global_position = entidade_spawn_position
