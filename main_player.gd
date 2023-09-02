extends CharacterBody2D


const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.

@onready var anim = get_node("AnimationPlayer")

func _physics_process(delta):
	# Add the gravity.
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var ydirection = Input.get_axis("ui_up", "ui_down")
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
