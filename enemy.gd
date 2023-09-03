extends CharacterBody2D
var speed = 150
var player_chase = false
var player = null
var direction = 0
var attack = 0
var hit = 0
var hp = 100 - hit
#var player_hp_singleton = preload("res://singleton.gd")


func set_hp(new_hp):
	hp = new_hp

func get_hp():
	return hp
	
func _physics_process(_delta):
	if hp < 1:
		$AnimatedSprite2D.play("death")
		await get_tree().create_timer(3).timeout 
		get_tree().change_scene_to_file("res://game_win.tscn")
#		get_tree().change_scene_to_file("res://game_win.tscn")
	else:
	#	print(attack)
		if player_chase:
			if attack == 1: 
				$AnimatedSprite2D.play("Attack")
			else:
				print(position)
				position += (player.position - position)/speed
				if direction == 0:
					$AnimatedSprite2D.play("Right")
				else: 
					$AnimatedSprite2D.play("Left")
		else: 
			$AnimatedSprite2D.play("Idle")

		



#func _on_detection_area_body_entered(body):
#	player = body
#	player_chase = true



func _on_detection_area_body_exited(_body):
	player = null
	player_chase = false
	$AnimatedSprite2D.play("Idle")


func _on_right_side_body_entered(body):
	direction = 0
	player = body
	player_chase = true

func _on_left_side_body_entered(body):
	direction = 1
	player = body
	player_chase = true


func _on_attack_range_body_entered(_body):
	attack = 1


func _on_attack_range_body_exited(_body):
	attack = 0


func _on_hitbox_body_entered(_body):
	$hpbar.value = hp
	hit += 1
	hp = 100 - hit
	print("real hp is", hp)
	

	
