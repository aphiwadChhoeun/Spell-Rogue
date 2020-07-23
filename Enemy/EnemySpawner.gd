extends Node

const Blob = preload("res://Enemy/Blob.tscn")

onready var timer = $Timer
onready var playerStats = PlayerStats

onready var topleft = null
onready var bottomright = null

func _ready():
	playerStats.connect("no_health", self, "stop_spawn")
	
func start_spawn(tl, br):
	topleft = tl
	bottomright = br
	timer.start()

func stop_spawn():
	timer.stop()
	
func reset():
	timer.wait_time = 1.0
	timer.start()

func _on_Timer_timeout():	
	if EnemyPool.enemie_count < 50:
		var enemy = Blob.instance()
		get_parent().add_child(enemy)
		enemy.global_position.x = rand_range(topleft.position.x + 25, bottomright.position.x - 25)
		enemy.global_position.y = rand_range(topleft.position.y + 25, bottomright.position.y - 25)
	
	timer.wait_time = max(0.1, timer.wait_time - 0.01)
	timer.start()
