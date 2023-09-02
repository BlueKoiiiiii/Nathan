extends RigidBody2D
var hitted = false


func _on_hitbox_body_entered(body):
	$Bulletanim.play("explosion")
	print("hit")
