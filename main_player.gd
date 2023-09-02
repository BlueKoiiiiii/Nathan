extends CharacterBody2D
var bullet = preload("res://bullet.tscn").instantiate()


var WHO = 0
var it = 0
var SPEED = 500.0
var bulletspeed = 2000
# Get the gravity from the project settings to be synced with RigidBody nodes.

@onready var anim = get_node("AnimationPlayer")
func _physics_process(delta):
	print(EditorSceneFormatImporterBlend)
	# Add the gravity.
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var ydirection = Input.get_axis("ui_up", "ui_down")
	if Input.is_key_pressed(KEY_SHIFT):
		SPEED = 1250
	else:
		SPEED = 500
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
	if Input.is_action_just_pressed("LMB"):
		WHO += 1
		
	
	if WHO%2 == 0: 
		shoot()
		#print(WHO)
		bullet.visible = true
		it = 0
	else:
		if it == 0:
			bullet.visible = false
			it += 1
		
	

var SOMEONE = false
var bullet_to_my_head = null

func shoot():
	if !SOMEONE:
		get_parent().add_child(bullet)
		bullet_to_my_head = bullet 
		bullet.global_position = global_position
		var target = get_global_mouse_position()
		var direction = target - global_position
		bullet.set_linear_velocity(direction)
		SOMEONE = true
#		bullet.play("default")
	else:
		var target = get_global_mouse_position()
		var direction = target - global_position
		bullet.set_linear_velocity(direction)
