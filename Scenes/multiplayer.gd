extends Node

const PORT = 1002

# Called when the node enters the scene tree for the first time.
func _ready():
	# get_tree().paused = true
	multiplayer.server_relay = false
	if DisplayServer.get_name() == "headless":
		print("Automatically starting dedicated server.")
		_on_host_pressed.call_deferred()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_host_pressed():
	print("uwu")
	get_tree().paused = true
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed tos tart multi player", "ERROR")
		return
	multiplayer.multiplayer_peer = peer
	


func _on_connect_pressed():
	# Start as client.
	get_tree().paused = true
	var txt : String = $MultiUi/ip.text
	if txt == "":
		OS.alert("Need a remote to connect to.")
		return
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(txt, PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer client.")
		return
	multiplayer.multiplayer_peer = peer
	start_game()
	

func start_game():
	$Nathan.hide()
	get_tree().paused = false

