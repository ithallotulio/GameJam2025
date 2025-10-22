extends CharacterBody2D

@export var speed := 150
@export var sprint_multiplier := 1.5
@onready var sprite = $AnimatedSprite2D

var last_move_input = null

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	
	if Input.is_action_pressed("sprint"):
		velocity *= sprint_multiplier
	
	move_animate()
	move_and_slide()


func move_animate():
	if Input.is_action_pressed("move_right"):
		last_move_input = "move_right"
		if Input.is_action_pressed("sprint"):
			sprite.play("walk-east", 4.0)
		else:
			sprite.play("walk-east")
	elif Input.is_action_pressed("move_left"):
		last_move_input = "move_left"
		if Input.is_action_pressed("sprint"):
			sprite.play("walk-west", 4.0)
		else:
			sprite.play("walk-west")
	elif Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"):
		if last_move_input == "move_right":
			sprite.play("walk-east")
			if Input.is_action_pressed("sprint"):
				sprite.play("walk-east", 4.0)
		else: # last_move_input == move_left
			sprite.play("walk-west")
			if Input.is_action_pressed("sprint"):
				sprite.play("walk-west", 4.0)
	else:
		if last_move_input == "move_right":
			sprite.play("idle-east")
		else: # last_move_input == move_left
			sprite.play("idle-west")
