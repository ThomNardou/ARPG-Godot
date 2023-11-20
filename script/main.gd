extends Node2D

var global = Global

# Called when the node enters the scene tree for the first time.
func _ready():
	global.is_dead = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.is_dead:
		get_tree().reload_current_scene()
