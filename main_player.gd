extends CharacterBody2D
var bullet = preload("res://bullet.tscn")
var enemy = preload("res://enemy.tscn").instantiate()
@onready 
#onready var bullet = $bullet
var WHO = 0
var it = 0
var SPEED = 500.0
var bulletspeed = 2000
var hp = 100
var hit = 1
var acceptance = false
var heal1 = true
var heal2 = true
# Get the gravity from the project settings to be synced with RigidBody nodes.


	
	
@onready var anim = get_node("AnimationPlayer")
func _physics_process(_delta):
	# print(EditorSceneFormatImporterBlend)
	# Add the gravity.
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var ydirection = Input.get_axis("ui_up", "ui_down")
	if Input.is_key_pressed(KEY_SHIFT):
		SPEED = 10000
	if ydirection:
		velocity.y = ydirection * SPEED
		if velocity.x == 0:
			if velocity.y < 0: 
				anim.play("Up")
			if velocity.y > 0: 
				anim.play("Down")
	else: velocity.y = move_toward(velocity.y, 0, SPEED)
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.y ==0: 
			if velocity.x > 0: 
				anim.play("Right")
			if velocity.x < 0:
				anim.play("Left")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y ==0: 
			anim.play("Idle")
	
	move_and_slide()
	SPEED = 500
	if Input.is_action_just_pressed("LMB"):
#		WHO += 1
		shoot()
	if hp < 0:
		get_tree().change_scene_to_file("res://game_over.tscn")

	
#	if WHO%2 == 0: 
#		shoot()
#		#print(WHO)
#		bullet.visible = true
#		it = 0
#	else:
#		if it == 0:
#			bullet.visible = false
#			it += 1
#
	

func shoot():
	var factor = 2.5
	var temp = bullet.instantiate()
	temp.position.y += 1000
	temp.global_position = global_position
	var target = get_global_mouse_position()
	var direction = target - global_position
	temp.set_linear_velocity(direction*factor)
	get_parent().add_child(temp)




#func shoot():
#	if !SOMEONE:
#		get_parent().add_child(bullet)
#		bullet_to_my_head = bullet 
#		bullet.global_position = global_position
#		var target = get_global_mouse_position()
#		var direction = target - global_position
#		bullet.set_linear_velocity(direction)
#		SOMEONE = true
##		bullet.play("default")
#	else:
#		var target = get_global_mouse_position()
#		var direction = target - global_position
#		bullet.set_linear_velocity(direction)

func _on_playerhitbox_body_entered(_body):
	acceptance = true
	if acceptance:
		$hpbar.value = hp
		hit += 20
		hp = 100 - hit

	
#	print("real hp is", hp)


func _on_playerhitbox_body_exited(_body):
	acceptance = false


func _on_area_2d_body_entered(body):
	var player = get_tree().get_nodes_in_group("player")[0]
	var playerpos = player.get_position()
	if playerpos.x >= 2200 and playerpos.x <= 2400:
		if playerpos.y >= 700 or playerpos.y <= 850:
			if heal1:
				print("healed")
				$hpbar.value +=10
				heal1 = false
				


func _on_area_2d_2_body_entered(body):
	var player = get_tree().get_nodes_in_group("player")[0]
	var playerpos = player.get_position()
	print(playerpos)
	if playerpos.x >= 4000 and playerpos.x <= 4175:
		if playerpos.y >= 375 or playerpos.y <= 525:
			if heal2:
				print("healed")
				$hpbar.value +=10
				heal2 = false
