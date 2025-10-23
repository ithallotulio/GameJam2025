extends Panel

@onready var sprite = $Sprite2D

var stages = 8

func update(currentStamina, maxStamina):
	var staminaPercentage = float(currentStamina) / maxStamina
	var stagesPercentage = 1.0 / stages
	var frame = (staminaPercentage / stagesPercentage)

	sprite.set_frame(frame)
