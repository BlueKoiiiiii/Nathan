extends Node2D

const PORT = 3344
var connected = false
var PlayerPosition = Vector2(0,0)
var players = {}
var player_info = {"name" : "NAME", "id": ""}
var playerKinematic = preload("res://main_player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connected_fail)

func _physics_process(delta):
	PlayerPosition.x = get_node("Main Player").position.x
	PlayerPosition.y = get_node("Main Player").position.y
	

func _on_connected_fail(id):
	print("u failed dumbass")

func _on_player_connected(id):
	print("kys")
	player_info["id"] = multiplayer.get_unique_id()
	_make_player.rpc_id(id, player_info, PlayerPosition)


@rpc("call_remote","reliable")
func _make_player(info, theirPosition):
	print(info)
	print(theirPosition)
	print(multiplayer.get_remote_sender_id())
	var temp_character = playerKinematic.instantiate()
	temp_character.position = theirPosition
	var tempLabel = Label.new()
	tempLabel.text = info["name"]
	temp_character.add_child(tempLabel)
	self.add_child(temp_character)
	

func _on_connected_ok():
	print("kms")
	

func _on_host_pressed():
	if !connected:
		var peer = ENetMultiplayerPeer.new()
		peer.create_server(PORT, 4)
		multiplayer.multiplayer_peer = peer
		print("hosting uwu")
		player_info["name"] = $Multi/Ui/LineEdit2.text
		print(player_info["name"])

func _on_connect_pressed():
	if !connected:
		var retard : String = $Multi/Ui/LineEdit.text
		var peer = ENetMultiplayerPeer.new()
		peer.create_client(retard, PORT)
		multiplayer.multiplayer_peer = peer
		print("connected owo")
		player_info["name"] = $Multi/Ui/LineEdit2.text
		print(player_info["name"])
		print(multiplayer.get_unique_id())
