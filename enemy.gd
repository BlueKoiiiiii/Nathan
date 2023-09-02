extends CharacterBody2D
var speed = 150
var player_chase = false
var player = null
var direction = 0
var attack = 0
var hit = 0
var hp = 100


func _physics_process(delta):
	# print(hp)
	if player_chase:
		if attack == 1: 
			$AnimatedSprite2D.play("Attack")
		else:
			position += (player.position - position)/speed
			if direction == 0:
				$AnimatedSprite2D.play("Right")
			else: 
				$AnimatedSprite2D.play("Left")
	else: 
		$AnimatedSprite2D.play("Idle")
	
		



func _on_detection_area_body_entered(body):
	player = body
	player_chase = true



func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
	$AnimatedSprite2D.play("Idle")


func _on_right_side_body_entered(body):
	direction = 0


func _on_left_side_body_entered(body):
	direction = 1


func _on_attack_range_body_entered(body):
	var attack = 1


func _on_attack_range_body_exited(body):
	var attack = 0


func _on_hitbox_body_entered(body):
	$hpbar.value = hp
	hit += 1
	hp = hp - hit
	# print(hp)
