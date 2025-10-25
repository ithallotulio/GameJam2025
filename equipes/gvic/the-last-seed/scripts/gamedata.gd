extends Node


# player
var heat = 0
var stamina = 400
var speed_amount_per_level = 5
var score = 0
var player_name = "n/a"
# player skills
var plant_level = 0
var speed_level = 0


# rank
var highscore = 0
var highscore_player_name = "n/a"
var top_10 = []
var all_players = []

# world
var day = 0
var sappling_list = []
var plantable: Vector2i


# difficulty settings / game balance settings
var world_hot_increase = 0.05
var entidade_speed_increase = 1


func load_player(player: CharacterBody2D):
	Gamedata.heat = player.heat
	Gamedata.stamina = player.stamina
	Gamedata.score = player.score
	
	Gamedata.plant_level = player.plant_level
	Gamedata.speed_level = player.speed_level


func save_player(player: CharacterBody2D):
	player.heat = Gamedata.heat
	player.stamina = Gamedata.stamina
	player.score = Gamedata.score
	
	player.plant_level = Gamedata.plant_level
	player.speed_level = Gamedata.speed_level
