extends Node

# player
var heat = 0
var stamina = 400
var plant_level = 0
var score = 1
var player_name = "n/a"

# rank
var highscore = 0
var highscore_player_name = "n/a"


# world
var sappling_list = []
var plantable: Vector2i


func load_player(player: CharacterBody2D):
	Gamedata.heat = player.heat
	Gamedata.stamina = player.stamina
	Gamedata.plant_level = player.plant_level
	Gamedata.score = player.score


func save_player(player: CharacterBody2D):
	player.heat = Gamedata.heat
	player.stamina = Gamedata.stamina
	player.plant_level = Gamedata.plant_level
	player.score = Gamedata.score
