extends Node2D

var global = Global

func _ready():
	$skeleton.play()

func _on_button_pressed():
	get_tree().root.add_child(global.game)
