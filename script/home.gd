extends Node2D

var global = Global

func _ready():
	$AudioStreamPlayer2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("test2"):
		global.is_in_home = false
		get_tree().change_scene_to_file("res://scenes/main.tscn")
		queue_free()
