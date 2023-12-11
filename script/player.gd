extends CharacterBody2D

var globale = Global

var health = 0
var can_take_damage = false
var entred : bool = false

var can_attack = false
var enemy 

var file

@export var speed = 35
@onready var animation = $Sprite2D/AnimationPlayer

@export var start_position = 150

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		
		file = FileAccess.open(globale.life_save_path, FileAccess.WRITE)
		file.store_64(health)
		
func _ready():
	if FileAccess.file_exists(globale.player_save_path) and globale.is_in_home == false:
		file = FileAccess.open(globale.player_save_path, FileAccess.READ)
		self.position = file.get_var()
	else:
		position.x = start_position
		position.y = start_position

	if FileAccess.file_exists(globale.life_save_path) and !globale.is_dead:
		file = FileAccess.open(globale.life_save_path, FileAccess.READ)
		health = file.get_64()
	else:
		health = 100

	
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
	
	globale.player_position = self.position
	
	if health <= 0:
		health = 0
		DirAccess.remove_absolute(globale.life_save_path)
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
		elif  enemy.has_method("skeleton"):
			health -= 15
		else:
			health -= 30
			
		var file = FileAccess.open(globale.life_save_path, FileAccess.WRITE)
		file.store_64(health)
			
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
