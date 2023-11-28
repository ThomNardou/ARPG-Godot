extends CharacterBody2D

var globale = Global

var health = 100
var can_take_damage = false
var entred : bool = false

var can_attack = false
var enemy 

@export var speed = 35
@onready var animation = $Sprite2D/AnimationPlayer

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		var file = FileAccess.open(globale.player_save_path, FileAccess.WRITE)
		file.store_var(self.position)
		
func _ready():
	var file = FileAccess.open(globale.player_save_path, FileAccess.READ)
	self.position = file.get_var()


func _process(delta):
	globale.play_life = health

func handleInpute():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed
	
func  updateAnimation():
	if velocity.length() == 0:
		animation.stop()	
	
	else :
		var direction = "down"
	
		if velocity.x < 0: 
			direction = "walk"
		elif velocity.x > 0: 
			direction = "walk"
		elif velocity.y < 0:
			direction = "up"
			
		if Input.is_action_pressed("ui_right"):
			$Sprite2D.flip_h = false
		elif Input.is_action_pressed("ui_left"):
			$Sprite2D.flip_h = true
			
		animation.play(direction)
		

func  _physics_process(delta):
	handleInpute()
	move_and_slide()
	updateAnimation()
	boucle_damage()
	
	if health <= 0:
		health = 0
		globale.is_dead = true


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
		else:
			health -= 15
			
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

