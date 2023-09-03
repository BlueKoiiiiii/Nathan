extends Node2D

var players = {}
var player_ids
var player_info = {"name" : "bob"}
var ourPosition = Vector2(0,0)
var multiCharScene = preload("res://multi_char.tscn")




# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(_peer_connected)
	multiplayer.peer_disconnected.connect(_peer_disconnected)
	multiplayer.connected_to_server.connect(_connected_to_server)
	print("Almost")
#	var asd = get_node("Canvas")
#	self.remove_child(asd)
\
	
#	if first_time != 0:
#		second_time = 0
#		print("second_time")

func _physics_process(_delta):
	var deleted = is_instance_valid("Canvas")
#	if first_time == 0: 
#		$"Main Player".global_position = $Marker2D.global_position
#		await get_tree().create_timer(1).timeout
#		first_time = 1
#		print("first done")
#	if second_time == 0:
	if ourPosition.y < -1: 
		get_tree().change_scene_to_file("res://game_win_2.tscn")

	ourPosition = get_node("Main Player").position
	var temp_peers = multiplayer.get_peers()
	for k in temp_peers:
		if !(k == multiplayer.get_unique_id()):
			_positions_update.rpc_id(k, ourPosition)

#		print("deleted", asd)
	#print(ourPosition)

func _peer_connected(id):
	_register_player.rpc_id(id,player_info, ourPosition)

func _peer_disconnected(id):
	player_info.erase(id)

@rpc("call_remote", "reliable")
func _positions_update(theirPosition):
	var nood = get_node(str(multiplayer.get_remote_sender_id()))
	print(nood)
	nood.position.x = theirPosition.x
	nood.position.y = theirPosition.y

@rpc("any_peer", "reliable")
func _register_player(new_player_info, theirPosition):
	print(theirPosition)
	var new_player_id = multiplayer.get_remote_sender_id()
	players[new_player_id] = new_player_info
	var tempChar = multiCharScene.instantiate()
	tempChar.set_name(str(multiplayer.get_remote_sender_id()))
	tempChar.position.x = theirPosition.x
	tempChar.position.y = theirPosition.y
	self.add_child(tempChar)
#	tempChar.position.y = theirPosition.y	


func _connected_to_server():
	print("Connected")
	var peer_id = multiplayer.get_unique_id()
	players[peer_id] = player_info
	

@rpc("call_local", "reliable")
func load_game(_game_scene_path, _seed1):
	pass



func _on_connect_pressed():
	print("connect")
	var ip = $Multi/Ui/LineEdit.text
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, 3344)
	multiplayer.multiplayer_peer = peer


func _on_host_pressed():
	print("host")
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(3344, 8)
	multiplayer.multiplayer_peer = peer
	players[1] = player_info


