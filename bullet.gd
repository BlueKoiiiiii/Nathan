extends RigidBody2D
#var hitted = false
#
#
#func _ready():
#	var main_player = preload("res://main_player.tscn")
#	var instance = main_player.instantiate()
#	var explode = instance.explode
#	if explode:
#		$Bulletanim.play("explosion")
#	else:
#		$Bulletanim.play("default")

#func _on_hitbox_body_entered(body):
#	hitted = true
#	await get_tree().create_timer(3).timeout
#	hitted = false
#
#func _on_hitbox_area_entered(area):
#	hitted = true 
#	await get_tree().create_timer(3).timeout
#	hitted = false
