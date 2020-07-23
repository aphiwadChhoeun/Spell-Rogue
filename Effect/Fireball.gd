extends Area2D

const HitEffect = preload("res://Effect/HitEffect.tscn")

export var speed = 180
onready var damage = 1
 
func _physics_process(delta):
	position += transform.x * speed * delta

# warning-ignore:unused_argument
func _on_Fireball_area_entered(area):
	if area.is_in_group('EnemyHurtbox'):
		var effect = HitEffect.instance()
		get_tree().current_scene.add_child(effect)
		effect.global_position = global_position
	queue_free()


# hitting wall
func _on_Fireball_body_entered(body):
	queue_free()
