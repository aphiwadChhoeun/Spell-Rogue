extends Node2D

export (PackedScene) var Fireball

onready var muzzle = $Muzzle
onready var shootSound = $ShootSound

# warning-ignore:unused_argument
func _physics_process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	shootSound.play()
	var fireball = Fireball.instance()
	get_tree().current_scene.add_child(fireball)
	fireball.global_transform = muzzle.global_transform
