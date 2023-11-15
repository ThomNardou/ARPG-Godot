extends CharacterBody2D

var global = Global

var speed = 60
var player_chase = false
var player = null

var health

func _physics_process(delta):
	health = global.slime_life
	$AnimatedSprite2D.play("move")
	
	if health <= 0:
		health = 0
		self.queue_free()
	
	if  player_chase:
		position += (player.position - position) / speed
		
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	

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
	
func slime():
	pass



