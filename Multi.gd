extends Control

@export var Address = "127.0.0.1"
@export var port = 3344
var worldScene = preload("res://world.tscn")

var peer
# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func peer_connected(id):
	print("Player connected " + str(id))

func peer_disconnected(id):
	print("Player disconnected " + str(id))


func connected_to_server():
	print("Connected to server")

func connection_failed():
	print("Connection failed")

@rpc("any_peer","call_local")
func StartGame():
	var scene = load("res://testScene.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()

func _on_host_pressed():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(3344,8)
	if error != OK:
		print("cannot host: " + error)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	print("Waiting for players")
	

func _on_join_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(Address, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)


func _on_start_pressed():
	StartGame().rpc()
