extends RigidBody2D
var hit = false

func _on_body_entered(body):
	$Bulletanim.play("explosion")
	await get_tree().create_timer(3).timeout
	$Bulletanim.play("default")
	



