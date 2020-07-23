extends Node

export var max_health = 3 setget set_max_health

var live = false
var health = max_health setget set_health
var killed = 0 setget set_killed

signal no_health
signal health_changed(value)
signal max_health_changed(value)
signal killed(value)

func set_killed(value):
	killed = value
	emit_signal("killed")

func set_health(value):
	health = min(value, max_health)
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func _ready():
	self.health = max_health
