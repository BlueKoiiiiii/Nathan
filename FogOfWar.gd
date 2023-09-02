extends TileMap

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = get_tree().get_nodes_in_group("player")[0]
	var playerpos = player.get_position()
	var tile = local_to_map(playerpos)
	erase_cell(0, tile)
	var tile1 = tile
	tile1.x += 1
	erase_cell(0, tile1)
	var tile2 = tile
	tile2.x += 2
	erase_cell(0, tile2)
	var tile3 = tile
	tile3.x += -1
	erase_cell(0, tile3)
	var tile4 = tile
	tile4.x += -2
	erase_cell(0, tile4)
	var tile5 = tile
	tile5.y += 1
	erase_cell(0, tile5)
	var tile6 = tile
	tile6.y += 2
	erase_cell(0, tile6)
	var tile7 = tile
	tile7.y += -1
	erase_cell(0, tile7)
	var tile8 = tile
	tile8.y += -2
	erase_cell(0, tile8)
	var tile9 = tile1
	tile9.y += 1
	erase_cell(0, tile9)
	var tile10 = tile1
	tile10.y += 2
	erase_cell(0, tile10)
	var tile11 = tile2
	tile11.y += 1
	erase_cell(0, tile11)
	var tile12 = tile2
	tile12.y += 2
	erase_cell(0, tile12)
	var tile13 = tile1
	tile13.y += -1
	erase_cell(0, tile13)
	var tile14 = tile1
	tile14.y += -2
	erase_cell(0, tile14)
	var tile15 = tile2
	tile15.y += -1
	erase_cell(0, tile15)
	var tile16 = tile2
	tile16.y += -2
	erase_cell(0, tile16)
	var tile17 = tile3
	tile17.y += 1
	erase_cell(0, tile17)
	var tile18 = tile3
	tile18.y += 2
	erase_cell(0, tile18)
	var tile19 = tile4
	tile19.y += 1
	erase_cell(0, tile19)
	var tile20 = tile4
	tile20.y += 2
	erase_cell(0, tile20)
	var tile21 = tile3
	tile21.y += -1
	erase_cell(0, tile21)
	var tile22 = tile3
	tile22.y += -2
	erase_cell(0, tile22)
	var tile23 = tile4
	tile23.y += -1
	erase_cell(0, tile23)
	var tile24 = tile4
	tile24.y += -2
	erase_cell(0, tile24)
	
