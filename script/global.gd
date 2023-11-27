extends Node

@onready var game = preload("res://scenes/main.tscn").instantiate()

var save_path = "res://score.save"

var play_life = 100
var is_dead = false

var player_score = 0
