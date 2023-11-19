extends CharacterBody2D

var globale = Global
var health = 100
var can_take_damage = false
var entred : bool = false

var can_attack = false
var enemy 

@export var speed = 35
@onready var animation = $AnimatedSprite2D

func _process(delta):
	globale.play_life = health

func handleInpute():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed
	
func  updateAnimation():
	if velocity.length() == 0:
		animation.stop()	
	
	else :
		var direction = "up"
	
		if velocity.x < 0: 
			direction = "walk"
		elif velocity.x > 0: 
			direction = "walk"
		elif velocity.y < 0:
			direction = "up"
			
		if velocity.x != 0:
			$AnimatedSprite2D.flip_h = velocity.x < 0
			
		animation.play(direction)
		

func  _physics_process(delta):
	handleInpute()
	move_and_slide()
	updateAnimation()
	boucle_damage()
	attack()
	
	#print(can_attack)
	
	if health <= 0:
		health = 0
		hide()


func player():
	pass

func _on_take_damage_box_body_entered(body):
	if  body.has_method("enemy"):
		enemy = body
		can_take_damage = true
		entred = true


func _on_take_damage_box_body_exited(body):
	if  body.has_method("enemy"):
		enemy = null
		can_take_damage = false
		entred = false

func takeDamage():
	if can_take_damage:
		if enemy.has_method("slime"):
			health -= 10
		else :
			health -= 15
			
		print(health)
		can_take_damage = false
		$can_take_damage_timer.start()


func _on_timer_timeout():
	can_take_damage = true

func boucle_damage():
	while entred && can_take_damage:
		takeDamage()


func _on_attack_zone_body_entered(body):
	if body.has_method("enemy"):
		enemy = body
		can_attack = true


func _on_attack_zone_body_exited(body):
	if body.has_method("enemy"):
		enemy = null
		can_attack = false

func attack():
	if can_attack == true:
		if Input.is_action_just_pressed("attack"):
			globale.player_attck = true

