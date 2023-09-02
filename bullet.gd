extends RigidBody2D
var hit = false

	





func _on_hitbox_body_entered(body):
	await get_tree().create_timer(2).timeout
	$Bulletanim.play("explosion")
	await get_tree().create_timer(3).timeout
	$Bulletanim.play("default")
