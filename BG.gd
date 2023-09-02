extends TileMap

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = get_tree().get_nodes_in_group("player")[0]
	var playerpos = player.get_position()
	var tile = local_to_map(playerpos)
	print(tile)
	if tile.x == 187 or tile.x == 188 or tile.x == 189 or tile.x == 190 or tile.x == 191 or tile.x == 192:
		if tile.y == 162 or tile.y == 163 or tile.y == 164 or tile.y == 165 or tile.y == 166 or tile.y == 167 or tile.y == 168:
			var doorcollision = get_node("DoorCollision")
			self.remove_child(doorcollision)

