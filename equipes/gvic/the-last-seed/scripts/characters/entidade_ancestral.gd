 #func old():
	#@onready var player = get_node("/root/World/Player")
	#@onready var sprite = $AnimatedSprite2D
#
	#var boost = 0
	#var time_outside_range = 0.0
	#var move_towards_player = false
	#var max_time_outside_range = 3.0
#
	#func _physics_process(delta: float) -> void:
		#var in_attack_range = attack_player_range(200)
#
		#if not in_attack_range:
			#time_outside_range += delta
			#if time_outside_range >= max_time_outside_range:
				#move_towards_player = true
			#else:
				#move_towards_player = false
		#else:
			#time_outside_range = 0
			#move_towards_player = false
#
		#if move_towards_player:
			#move_towards_player_function(delta)
		#else:
			#random_boost()
#
		#move_and_slide()
#
#
	#func attack_player_range(atk_range: float) -> bool:
		#var direction = global_position.direction_to(player.global_position)
		#var player_distance = (global_position - player.global_position).length()
#
		#if player_distance <= atk_range:
			#velocity = direction * 160
			#sprite.play("anger", 1)
			#return true
#
		#return false
#
#
	#func move_towards_player_function(delta: float) -> void:
		#var direction = (player.global_position - global_position).normalized()
		#velocity = direction * 60
		#sprite.play("anger", 1)
#
#
	#func random_boost() -> void:
		#var odd = randi_range(1, 1000)
#
		#if odd == 1000:
			#boost = 150
#
		#if boost > 0:
			#sprite.play("anger", 4)
			#velocity *= 1.25
			#boost -= 1
#
			#if boost == 0:
				#sprite.play("anger", 1)

extends CharacterBody2D


@export var speed := 160
@export var target : CharacterBody2D
@onready var nav = $NavigationAgent2D


func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(nav.get_next_path_position())
	velocity = direction * speed
	
	var motion = direction * speed * delta
	var collision = move_and_collide(motion)
	
	if collision:
		var body = collision.get_collider()
		if body.is_in_group("player"):
			body.game_over()


func go_to_target():
	nav.target_position = target.position


func _on_navigation_timer_timeout() -> void:
	go_to_target()
