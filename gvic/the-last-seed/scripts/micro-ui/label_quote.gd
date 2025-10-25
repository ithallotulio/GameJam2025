extends Label

var full_text = "O fogo que vocês acenderam… agora consome tudo"
var current_index = 0
var typing_speed = 0.05
var time_passed = 0.0

func _process(delta):
	await get_tree().create_timer(1.5).timeout
	if current_index < full_text.length():
		time_passed += delta
		if time_passed >= typing_speed:
			text += full_text[current_index]
			current_index += 1
			time_passed = 0
