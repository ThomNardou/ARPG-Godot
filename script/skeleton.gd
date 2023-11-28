extends CharacterBody2D

var global = Global

var speed = 30
var player_chase = false
var player = null

var can_take_damage = false

var health = 100

func _physics_process(delta):
	
	if Input.is_action_just_pressed("attack") and can_take_damage:
		takeDamage()
	
	$Control/ProgressBar.value = health
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

func skeleton():
	pass
	
func takeDamage():
	health -= global.player_damage
	if health <= 0:
		global.player_score += 10
		global.skeleton_count_killed += 1
		queue_free()


func _on_can_be_attack_body_entered(body):
	if body.has_method("player"):
		can_take_damage = true


func _on_can_be_attack_body_exited(body):
	if body.has_method("player"):
		can_take_damage = false
