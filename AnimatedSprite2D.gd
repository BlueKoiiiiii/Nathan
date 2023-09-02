extends AnimatedSprite2D
var hit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.play("default")
	


func _on_bullet_body_entered(body):
	hit = true
