extends CharacterBody2D

@export var speed = 35
@onready var animation = $AnimatedSprite2D
var global = Global
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
	global.globalPlayerXPosition = $
	handleInpute()
	move_and_slide()
	updateAnimation()
