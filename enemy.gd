extends CharacterBody2D
var speed = 80
var player_chase = false
var player = null
var direction = 0

func _physics_process(delta):
	if player_chase:
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
