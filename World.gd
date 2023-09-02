extends Node2D

const PORT = 3344
var connected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connected_fail)

func _on_connected_fail(id):
	print("u failed dumbass")

func _on_player_connected(id):
	print("kys" + id)

func _on_connected_ok(id):
	print("kms" + id)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_host_pressed():
	if !connected:
		var peer = ENetMultiplayerPeer.new()
		peer.create_server(PORT, 4)
		multiplayer.multiplayer_peer = peer
		print("hosting uwu")
		print(multiplayer.get_unique_id())
		

func _on_connect_pressed():
	if !connected:
		var retard : String = $Multi/Ui/LineEdit.text
		var peer = ENetMultiplayerPeer.new()
		peer.create_client(retard, PORT)
		multiplayer.multiplayer_peer = peer
		print("connected owo")
		print(multiplayer.get_unique_id())
