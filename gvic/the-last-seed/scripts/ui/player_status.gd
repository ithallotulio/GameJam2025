extends VBoxContainer


func updateStamina(currentStamina, maxStamina):
	var stamina = $stamina
	stamina.update(currentStamina, maxStamina)


func updateHeat(currentHeat, maxHeat):
	var heat = $heat
	heat.update(currentHeat, maxHeat)
