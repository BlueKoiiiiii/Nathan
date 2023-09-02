extends RigidBody2D
var hitted = false
# @onready var Bullet = get_node("Bullet")

func _on_hitbox_body_entered(body):
	$Bulletanim.play("explosion")


func _on_hitbox_area_entered(area):
	pass
	
