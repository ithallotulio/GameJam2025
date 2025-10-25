extends Node2D


@onready var playerStatus = $Hud/PlayerStatus
@onready var player = $Player
@onready var heat_filter: ColorRect = $Hud/HeatFilter


func _ready() -> void:
	player.heat = Gamedata.heat
	player.stamina = Gamedata.stamina
	playerStatus.updateStamina(player.stamina, player.max_stamina)
	playerStatus.updateHeat(player.heat, player.max_heat)
	var heat_level = float(player.heat) / player.max_heat
	heat_filter.color = Color(255,0, 0, heat_level / 3)


func _on_status_timer_timeout() -> void:
	if (player.heat - 40) > 0:
		player.heat -= 40
	else:
		player.heat = 0
		
	if player.stamina + 60 < player.max_stamina:
		player.stamina += 60
	else:
		player.stamina = player.max_stamina
	var heat_level = float(player.heat) / player.max_heat
	heat_filter.color = Color(255,0, 0, heat_level / 3)
	
	playerStatus.updateStamina(player.stamina, player.max_stamina)
	playerStatus.updateHeat(player.heat, player.max_heat)
