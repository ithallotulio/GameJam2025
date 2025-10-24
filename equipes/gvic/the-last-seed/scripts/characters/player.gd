extends CharacterBody2D

@export var speed = 150
@export var sprint_multiplier = 1.5
@export var max_stamina = 400
@onready var sprite = $AnimatedSprite2D

var last_move_input = null
var stamina_recovery_time = 180
var stamina_recovery_amount = 0.5
var stamina = 400
var recovering = 0


func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
			
	if Input.is_action_pressed("sprint") and direction != Vector2.ZERO:
		recovering = 0
		if stamina > 0:
			velocity *= sprint_multiplier
			stamina -= 1
	else:
		recovering += 1
		if recovering >= stamina_recovery_time:
			if stamina < max_stamina:
				stamina += 0.5
				
	
	move_animate()
	move_and_slide()


func move_animate():
	if Input.is_action_pressed("move_right"):
		last_move_input = "move_right"
		if Input.is_action_pressed("sprint") and stamina > 0:
			sprite.play("walk-east", 4.0)
		else:
			sprite.play("walk-east")
	elif Input.is_action_pressed("move_left"):
		last_move_input = "move_left"
		if Input.is_action_pressed("sprint") and stamina > 0:
			sprite.play("walk-west", 4.0)
		else:
			sprite.play("walk-west")
	elif Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"):
		if last_move_input == "move_right":
			sprite.play("walk-east")
			if Input.is_action_pressed("sprint") and stamina > 0:
				sprite.play("walk-east", 4.0)
		else: # last_move_input == move_left
			sprite.play("walk-west")
			if Input.is_action_pressed("sprint") and stamina > 0:
				sprite.play("walk-west", 4.0)
	else:
		if last_move_input == "move_right":
			sprite.play("idle-east")
		else: # last_move_input == move_left
			sprite.play("idle-west")
			
			
func game_over():
	get_tree().change_scene_to_file("res://scenes/micro-ui/game_over.tscn")
