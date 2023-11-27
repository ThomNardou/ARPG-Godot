extends Node2D

var global = Global

func _ready():
	loadData()

func _on_button_pressed():
	get_tree().root.add_child(global.game)


func _on_load_data_pressed():
	loadData()


func loadData():
	if FileAccess.file_exists(global.save_path):
		print("trouvé")
		var file = FileAccess.open(global.save_path, FileAccess.READ)
		global.player_score = file.get_var()
	else:
		print("pas trouvé")
		global.player_score = 0
