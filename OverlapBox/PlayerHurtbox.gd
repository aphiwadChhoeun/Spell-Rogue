extends Area2D

onready var hurtSound = $SoundEffect

func _on_Hurtbox_area_entered(area):
	if area.is_in_group("EnemyHitbox"):
		hurtSound.play()
