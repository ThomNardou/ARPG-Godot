extends Node2D

var global = Global
var file

# Called when the node enters the scene tree for the first time.
func _ready():
	global.is_dead = false


func  _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		file = FileAccess.open(global.save_path, FileAccess.WRITE)
		file.store_var(global.player_score)
		
		file = FileAccess.open(global.slime_save_path, FileAccess.WRITE)
		file.store_var(global.slime_count_killed)
		
		file = FileAccess.open(global.skeleton_save_path, FileAccess.WRITE)
		file.store_var(global.skeleton_count_killed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.is_dead:
		queue_free()
		get_tree().change_scene_to_file("res://scenes/main.tscn")
