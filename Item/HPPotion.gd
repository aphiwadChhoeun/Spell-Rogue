extends StaticBody2D

onready var playerStats = PlayerStats
onready var captureSound = $CaptureSound

func _on_ConsumeArea_body_entered(body):
	playerStats.health += 1
	captureSound.play()
	visible = false

func _on_CaptureSound_finished():
	queue_free()
