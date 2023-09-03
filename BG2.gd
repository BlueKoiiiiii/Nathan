extends TileMap
var check = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_area_2d_4_body_entered(body):
	var player = get_tree().get_nodes_in_group("player")[0]
	var playerpos = player.get_position()
	var tile = local_to_map(playerpos)
	if tile.x >= 10 and tile.x <= 17:
		if tile.y >= 166 and tile.y <= 174:
			if check == 0:
				var doorcollision = get_node("DoorCollision2")
				self.remove_child(doorcollision)
				check += 1

