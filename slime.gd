extends CharacterBody2D

var global = Global

var speed = 40
var player_chase = false
var player = null

var can_take_damage = true

var health = 100
var player_attack_zone = false

func _physics_process(delta):
	deal_with_damage()
	
	if  player_chase:
		position += (player.position - position) / speed
	
		$AnimatedSprite2D.play("move")
		
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func enemy():
	pass


func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_attack_zone = true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_attack_zone = false
		
func deal_with_damage():
	if player_attack_zone and global.player_current_attack == true:
		if can_take_damage:
			health -= 10
			$takeDamage.start()
			can_take_damage = false
			print("vie du slime :", health)
			if health <= 0:
				self.queue_free()


func _on_take_damage_timeout():
	can_take_damage = true
