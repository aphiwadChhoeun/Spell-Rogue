extends Node2D

signal game_start

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		emit_signal("game_start")
