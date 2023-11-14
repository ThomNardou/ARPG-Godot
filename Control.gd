extends Control

var global = Global

@onready var label = $Label

func  _process(delta):
	label.text = str(global.play_life)
