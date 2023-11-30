extends Node

@onready var game = preload("res://scenes/main.tscn").instantiate()

var save_path = "res://Save/score.save"
var slime_save_path = "res://Save/slime.save"
var skeleton_save_path = "res://Save/skelton.save"
var player_save_path = "res://Save/player.save"
var life_save_path = "res://Save/life.save"

var play_life = 100
var is_dead = false
var player_damage = 10

var player_score = 0

var slime_count_killed = 0
var skeleton_count_killed = 0

var is_in_home = false

var player_position
