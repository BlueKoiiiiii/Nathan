extends CharacterBody2D
var bullet = preload("res://bullet.tscn")
var enemy = preload("res://enemy.tscn").instantiate()
@onready 
#onready var bullet = $bullet
var WHO = 0
var it = 0
var SPEED = 2000
var bulletspeed = 2000
var hp = 100
var hit = 1
var acceptance = false
var heal1 = true
var heal2 = true
var heal3 = true
var heal4 = true
var heal5 = true
# Get the gravity from the project settings to be synced with RigidBody nodes.


func _ready():
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())
#	await(get_tree().process_frame)
#	if multiplayer.is_server():
#		GameManager.player_master = self
	

@onready var anim = get_node("AnimationPlayer")
func _physics_process(_delta):
	# print(EditorSceneFormatImporterBlend)

	if hp < 0:
		get_tree().change_scene_to_file("res://game_over.tscn")
		GameManager.hpdead = true

	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		var ydirection = Input.get_axis("W", "S")
		if Input.is_action_just_pressed("SHIFT"):
			SPEED = 100000
		if ydirection:
			velocity.y = ydirection * SPEED
			if velocity.x == 0:
				if velocity.y < 0: 
					anim.play("Up")
				if velocity.y > 0: 
					anim.play("Down")
		else: velocity.y = move_toward(velocity.y, 0, SPEED)
		var direction = Input.get_axis("A", "D")
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
			shoot.rpc()
		if hp < 0:
			get_tree().change_scene_to_file("res://game_over.tscn")
			
	
#	var player = get_tree().get_nodes_in_group("player")[0]
#	var playerpos = player.get_position()
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
	
@rpc("any_peer","call_local")
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




func _on_area_2d_body_entered(body):
	var player = get_tree().get_nodes_in_group("player")[0]
	var playerpos = player.get_position()
	if playerpos.x >= 2200 and playerpos.x <= 2400:
		if playerpos.y >= 700 and  playerpos.y <= 850:
			if heal1:
				print("healed")
				$hpbar.value +=10
				heal1 = false
	
	
	

func _on_area_1_stpotion_body_entered(body):
	var player = get_tree().get_nodes_in_group("player")[0]
	var playerpos = player.get_position()
	if playerpos.x >= 2000 and playerpos.x <= 2500:
		if playerpos.y >= 2225 and playerpos.y <= 3000:
			print("boundary")
			if heal3:
				print("healed")
				$hpbar.value +=10
				heal3 = false
				


func _on_area_2d_2_body_entered(body):
	var player = get_tree().get_nodes_in_group("player")[0]
	var playerpos = player.get_position()
	if playerpos.x >= 4000 and playerpos.x <= 4175:
		if playerpos.y >= 375 and playerpos.y <= 525:
			if heal2:
				print("healed")
				$hpbar.value +=10
				heal2 = false
	
	


func _on_areasecondpotion_body_entered(body):
	var player = get_tree().get_nodes_in_group("player")[0]
	var playerpos = player.get_position()
	if playerpos.x >= 1450 and playerpos.x <= 1900:
		if playerpos.y >= 950 and playerpos.y <= 1400:
			if heal4:
				print("healed")
				$hpbar.value +=10
				heal4 = false


func _on_area_2d_3_body_entered(body):
	var player = get_tree().get_nodes_in_group("player")[0]
	var playerpos = player.get_position()
	if playerpos.x >= 3400 and playerpos.x <= 3800:
		if playerpos.y >= -600 and playerpos.y <= -200:
			if heal5:
				print("healed")
				$hpbar.value +=10
				heal5 = false
	





func _on_playerhitbox_body_entered(_body):
		$hpbar.value = hp
		hit += 5
		hp = 100 - hit
#	print("real hp is", hp)


	
	

#		acceptance = false


