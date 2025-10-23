extends Node2D


@onready var playerStatus = $Hud/PlayerStatus
@onready var player = $Player


func _on_status_timer_timeout() -> void:
	playerStatus.updateStamina(player.stamina, player.max_stamina)
