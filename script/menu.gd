extends Node2D

var global = Global
var file

func _ready():
	loadData()
	$Window/Label.text = "Skeleton killed : " + str(global.skeleton_count_killed) + "\n" + "Slime killed : " + str(global.slime_count_killed)

func _on_button_pressed():
	get_tree().root.add_child(global.game)

func loadData():
	if FileAccess.file_exists(global.save_path):
		print("trouvé")
		file = FileAccess.open(global.save_path, FileAccess.READ)
		global.player_score = file.get_var()
		
		file = FileAccess.open(global.slime_save_path, FileAccess.READ)
		global.slime_count_killed = file.get_var()
		
		file = FileAccess.open(global.skeleton_save_path, FileAccess.READ)
		global.skeleton_count_killed = file.get_var()
		
	else:
		print("pas trouvé")
		global.player_score = 0
		global.skeleton_count_killed = 0
		global.slime_count_killed = 0


func _on_stats_pressed():
	$Window.show()
	



func _on_window_close_requested():
	$Window.hide()
