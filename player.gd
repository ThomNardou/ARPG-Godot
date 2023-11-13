extends CharacterBody2D

var globale = Global

var enemy_attack_range = false
var enemy_attack_cooldown = true

var health = 100
var player_alive = true

var direction = "none"

var attack_ip = false

@export var speed = 35
@onready var animation = $AnimatedSprite2D

func handleInpute():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed
	
func  updateAnimation():
	
	if velocity.length() == 0:
		animation.stop()	
	
	else :

		direction = "up"
	
		if velocity.x < 0: 
			if !attack_ip:
				direction = "walk"
		elif velocity.x > 0: 
			if !attack_ip:
				direction = "walk"
		elif velocity.y < 0:
			if !attack_ip:
				direction = "up"
			
		if velocity.x != 0:
			$AnimatedSprite2D.flip_h = velocity.x < 0
		animation.play(direction)
		

func  _physics_process(delta):
	handleInpute()
	move_and_slide()
	updateAnimation()
	
	enemyAttack()
	attack()
	
	if  health <= 0:
		player_alive = false
		health = 0
		print("tu es mort")
		hide()
	

func player():
	pass

func _on_player_hit_box_body_entered(body):
	if body.has_method("enemy"):
		enemy_attack_range = true


func _on_player_hit_box_body_exited(body):
	if body.has_method("enemy"):
		enemy_attack_range = false

func enemyAttack():
	if enemy_attack_range and enemy_attack_cooldown == true:
		health -= 10
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)


func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
	
func attack():
	var dir = direction
	
	if Input.is_action_just_pressed("attack"):
		globale.player_current_attack = true
		attack_ip = true
		
		if dir == "walk":
			$deal_attack_timer.start()
		
		if dir == "up":
			$deal_attack_timer.start()


func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	globale.player_current_attack = false
	attack_ip = false
