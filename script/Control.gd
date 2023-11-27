extends Control

var global = Global

@onready var progressBar = $ProgressBar
@onready var scoreLabel = $Label

func  _process(delta):
	progressBar.value = global.play_life
	scoreLabel.text = "Score : " + str(global.player_score)
