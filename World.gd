extends Node2D

var players = {}
var player_info = {"name" : "bob"}
var ourPosition = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(_peer_connected)
	multiplayer.peer_disconnected.connect(_peer_disconnected)
	multiplayer.connected_to_server.connect(_connected_to_server)

func _physics_process(_delta):
	ourPosition = get_node("Main Player").position
	if ourPosition.y < -1:
		get_tree().change_scene_to_file("res://game_win_2.tscn")
	#print(ourPosition)

func _peer_connected(id):
	_register_player.rpc_id(id, player_info, ourPosition)

func _peer_disconnected(id):
	player_info.erase(id)
	

func _connected_to_server():
	print("Connected")
	var peer_id = multiplayer.get_unique_id()
	players[peer_id] = player_info

@rpc("call_local", "reliable")
func load_game(_game_scene_path, _seed1):
	pass

@rpc("any_peer", "reliable")
func _register_player(new_player_info):
	var new_player_id = multiplayer.get_remote_sender_id()
	players[new_player_id] = new_player_info
	

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

