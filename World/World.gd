extends Node2D

onready var camera = $Camera2D
onready var enemySpawner = $YSort/EnemySpawner
onready var menu = $HealthUIContainer/Menu
onready var ysort = $YSort

const Player = preload("res://Player/Player.tscn")

onready var topleft = null
onready var bottomright = null

func _ready():
	randomize()
	topleft = camera.topleft
	bottomright = camera.bottomright
	
func _on_Menu_game_start():
	if topleft !=null and bottomright != null:
		var enemies = get_tree().get_nodes_in_group("Enemy")
		for e in enemies:
			e.queue_free()
		
		if PlayerStats.live == false:
			reset_game()
		
		menu.visible = false
		enemySpawner.start_spawn(topleft, bottomright)

func reset_game():
	var player = Player.instance()
	ysort.add_child(player)
	player.global_position.x = camera.bottomright.position.x / 2
	player.global_position.y = camera.bottomright.position.y / 2
	
	var remoteTransform = RemoteTransform2D.new()
	remoteTransform.remote_path = camera.get_path()
	player.add_child(remoteTransform)
	
	player.connect("player_died", self, "_on_Player_player_died")
	
	enemySpawner.reset()
	
	PlayerStats.killed = 0

func _on_Player_player_died():
	menu.visible = true
