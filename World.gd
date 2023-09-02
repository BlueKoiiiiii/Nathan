extends Node2D

var players = {}
var player_info = {"name" : "bob"}
var ourPosition = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(_peer_connected)
	multiplayer.peer_disconnected.connect(_peer_disconnected)
	multiplayer.connected_to_server.connect(_connected_to_server)

func _physics_process(delta):
	ourPosition = get_node("Main Player").position
	#print(ourPosition)

func _peer_connected(id):
#	_register_player.rpc_id(id)
#	_register_player(15,32)
	pass

@rpc("any_peer", "call_local", "reliable")
func _register_player(new_player_info, theirPosition):
	print(theirPosition)
	var new_player_id = multiplayer.get_remote_sender_id()
	players[new_player_id] = new_player_info
	

func _peer_disconnected(id):
	player_info.erase(id)
	

func _connected_to_server():
	print("Connected")
	var peer_id = multiplayer.get_unique_id()
	players[peer_id] = player_info

@rpc("call_local", "reliable")
func load_game(game_scene_path, seed):
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

