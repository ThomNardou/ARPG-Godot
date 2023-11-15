extends CharacterBody2D

var global = Global

var speed = 30
var player_chase = false
var player = null

var health

func _ready():
	health = global.skeleton_life
	print(health)

func _physics_process(delta):
	
	if  player_chase:
		$AnimatedSprite2D.play("move")
		position += (player.position - position) / speed
		
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.stop()
	

func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body
		player_chase = true


func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		player = null
		player_chase = false
		
func enemy():
	pass

func sekleton():
	pass



