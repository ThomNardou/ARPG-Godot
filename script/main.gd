extends Node2D

var global = Global
var file

# Called when the node enters the scene tree for the first time.
func _ready():
	global.is_dead = false
	$AudioStreamPlayer2D.play()
	#$player/Camera2D.position = $player.position


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
	if Input.is_action_just_pressed("test"):
		global.is_in_home = true
		file = FileAccess.open(global.player_save_path, FileAccess.WRITE)
		file.store_var(global.player_position)
		
		global.change_scene = true
		
		get_tree().change_scene_to_file("res://scenes/home.tscn")
		queue_free()
	
	if global.is_dead:
		queue_free()
		get_tree().change_scene_to_file("res://scenes/main.tscn")
