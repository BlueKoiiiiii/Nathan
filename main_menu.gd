extends Node2D




func _on_quit_pressed():
	get_tree().quit
	
func _on_play_pressed():
	$AnimatedSprite2D.play("default")
	await get_tree().create_timer(1.05).timeout
	get_tree().change_scene_to_file("res://multiplayer.tscn")
