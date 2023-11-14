extends Control

var global = Global

@onready var progressBar = $ProgressBar

func  _process(delta):
	progressBar.value = global.play_life
