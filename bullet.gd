extends RigidBody2D

func _ready():
	export (int) var speed = 500
	var direction  = Vector2.ZERO

func set_direction(direction: Vector2):
	self.direction = direction

func _process(delta: float) -> void
	if direction != Vector2.ZERO
		var velocity = direction * speed
		
		global_position += velocity
