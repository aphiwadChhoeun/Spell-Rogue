extends Control

onready var playerStats = PlayerStats
onready var  counter = $Counter

func _ready():
	playerStats.connect("killed", self, "update_ui")
	
func update_ui():
	counter.text = str(PlayerStats.killed)
