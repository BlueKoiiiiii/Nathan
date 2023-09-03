extends Node2D

var ourPosition = Vector2(0,0)
@export var PlayerScene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var index = 0
	for i in GameManager.Players:
		var currentPlayer = PlayerScene.instantiate()
		currentPlayer.name = str(GameManager.Players[i].id)
		add_child(currentPlayer)
		for spawn in get_tree().get_nodes_in_group("SpawnLocationPoint"):
			if spawn.name == str(index):
				currentPlayer.global_position = spawn.global_position
		index += 1
	pass

func _physics_process(_delta):
	var deleted = is_instance_valid("Canvas")
	# Future problem
#	if ourPosition.y < -1: 
#		get_tree().change_scene_to_file("res://game_win_2.tscn")
#	ourPosition = get_node("Main_Player").position
