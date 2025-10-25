extends Control

@onready var anim = $anim

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	anim.play("fade_out")
	await anim.animation_finished
	get_tree().change_scene_to_file("res://scenes/micro-ui/user_inputs.tscn")
