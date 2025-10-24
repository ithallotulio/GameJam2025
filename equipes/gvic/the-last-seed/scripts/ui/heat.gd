extends Panel

@onready var sprite = $Sprite2D

var stages = 8

func update(currentHeat, maxHeat):
	var heatPercentage = float(currentHeat) / maxHeat
	var stagesPercentage = 1.0 / stages
	var frame = (heatPercentage / stagesPercentage)

	sprite.set_frame(frame)
