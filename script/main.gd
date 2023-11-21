extends Node2D

var global = Global

# Called when the node enters the scene tree for the first time.
func _ready():
	global.is_dead = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.is_dead:
		queue_free()
		get_tree().change_scene_to_file("res://scenes/main.tscn")
