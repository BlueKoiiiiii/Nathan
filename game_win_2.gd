extends Node2D
var opacity = 0
var asd = true
@onready var captured_image = $CapturedImage
# Called when the node enters the scene tree for the first time.
func _ready():
	# Retrieve the captured image.
	var img = get_viewport().get_texture().get_image()

	# Create a texture for it.
	var tex = ImageTexture.create_from_image(img)

	# Set the texture to the captured image node.
	captured_image.set_texture(tex)
	#while(true):
		#pass
#		opacity += 0.1
#		modulate.a = opacity
#		await get_tree().create_timer(0.3).timeout


func _on_timer_timeout():
	if asd: 
		opacity += 0.01
		modulate.a = opacity
		if opacity > 1:
			opacity = 1
			asd = false
#
	
	
	
