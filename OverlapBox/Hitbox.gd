extends Area2D

export(int) var damage = 1

func _ready():
	add_to_group("EnemyHitbox")
