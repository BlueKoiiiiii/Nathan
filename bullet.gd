extends RigidBody2D
var hitted = false
# @onready var Bullet = get_node("Bullet")
var velocity = Vector2(200,200)




func _on_timer_timeout():
	queue_free()
