extends RigidBody2D
var hitted = false


func _on_hitbox_body_entered(body):
	$Bulletanim.play("explosion")
	print("hit")


func _on_hitbox_area_entered(area):
	Bullet = get_node("Bullet")
	$Bulletanim.play("explosion")
	print("hit")
	Bullet.set_sleeping(true)
