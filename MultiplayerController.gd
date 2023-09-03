extends Control

@export var Address = "127.0.0.1"
@export var PORT = 3344
var world = preload("res://world.tscn")
var game_over = preload("res://game_over.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)


#Gets called on server and clients when ppl connect
func peer_connected(id):
	print("Peer connected " + str(id))
# Vise versa
func peer_disconnected(id):
	print("Peer disconnected" + str(id))


#Client connects, client only
func connected_to_server():
	print("connected to server")
	SendPlayerInformation.rpc_id(1,$Name.text, multiplayer.get_unique_id())
#same~ish thing
func connection_failed():
	print("Coulding connect")
	
@rpc("any_peer")
func SendPlayerInformation(name, id):
	if(!GameManager.Players.has(id)):
		GameManager.Players[id] = {
			"name": name, 
			"id": id,
			"score": 0
		}
	if multiplayer.is_server():
		for i in GameManager.Players:
			SendPlayerInformation.rpc(GameManager.Players[i].name, i )
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

@rpc("any_peer","call_local")
func StartGame():
	var scene = world.instantiate()
	if GameManager.hpdead: 
		var temp = get_node("world")
		get_tree().root.remove_child(scene)
		get_parent().remove_child(GameManager)
		var losescreen = game_over.instantiate()
		get_tree().root.add_child(losescreen)
	else: 
		get_tree().root.add_child(scene)
		self.hide()

func _on_host_pressed():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT, 4)
	if error != OK:
		print("Cannot host: " + error)
		return
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	print("Waiting for playerss")
	SendPlayerInformation($Name.text, multiplayer.get_unique_id())

func _on_join_pressed():
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(Address, PORT)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)


func _on_start_pressed():
	StartGame.rpc()
	
	
	
