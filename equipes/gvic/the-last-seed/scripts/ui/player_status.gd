extends VBoxContainer


func updateStamina(currentStamina, maxStamina):
	var stamina = $stamina
	stamina.update(currentStamina, maxStamina)
