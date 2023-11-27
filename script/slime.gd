extends CharacterBody2D

var global = Global

var speed = 60
var player_chase = false
var player = null

var health = 100

var can_take_damage = false

func _physics_process(delta):
	
	if Input.is_action_just_pressed("attack") and can_take_damage:
		takeDamage()
	
	$AnimatedSprite2D.play("move")
	$Control/ProgressBar.value = health
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
		
func takeDamage():
	health -= global.player_damage
	print("slime life = ", health)
	if health <= 0:
		global.player_score += 5
		global.slime_count_killed += 1
		queue_free()

func _on_can_be_attack_body_entered(body):
	if body.has_method("player"):
		can_take_damage = true


func _on_can_be_attack_body_exited(body):
	if body.has_method("player"):
		can_take_damage = false
