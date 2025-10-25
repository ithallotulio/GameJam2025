extends Label

func _ready() -> void:
	text = "Moedas: %d" % [Gamedata.moedas]
