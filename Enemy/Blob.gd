extends KinematicBody2D

export var ACCELERATION = 95
export var MAX_SPEED = 50
export var FRICTION = 200

var velocity = Vector2.ZERO

enum {
	IDLE,
	WANDER,
	CHASE
}

onready var state = IDLE

const EnemyDeathEffect = preload("res://Effect/EnemyDeathEffect.tscn")
const HPPotion = preload("res://Item/HPPotion.tscn")
onready var playerDetection = $PlayerDetection
onready var stats = $Stats
onready var sprite = $AnimatedSprite
onready var softCollision = $SoftCollision
onready var hurtbox = $EnemyHurtbox
onready var hitbox = $Hitbox

func _enter_tree():
	add_to_group("Enemy")
	EnemyPool.enemie_count += 1
	
func _exit_tree():
	EnemyPool.enemie_count -= 1

# warning-ignore:unused_argument
func _physics_process(delta):
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION)
			
		WANDER:
			velocity = velocity.move_toward(Vector2.ZERO * MAX_SPEED, ACCELERATION)
			seek_player()
			
		CHASE:
			state_chase()
	
	if(softCollision.is_colliding()):
		velocity += softCollision.get_push_vector() * ACCELERATION
	
	velocity = move_and_slide(velocity)

func state_chase():
	var player = playerDetection.player
	if player != null:
		var direction = global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION)
		sprite.flip_h = velocity.x < 0
	else:
		state = WANDER

func seek_player():
	if playerDetection.can_see_player():
		state = CHASE

func _on_Stats_no_health():
	PlayerStats.killed += 1
	
	random_and_spawn_potion()
	
	var death_effect = EnemyDeathEffect.instance()
	get_tree().current_scene.add_child(death_effect)
	death_effect.global_position = global_position
	
	queue_free()

func random_and_spawn_potion():
	var rng = rand_range(0, 100)
	if rng < 2.5:
		var potion = HPPotion.instance()
		get_parent().add_child(potion)
		potion.global_position = global_position

func _on_Timer_timeout():
	sprite.visible = true
	hitbox.monitorable = true
	hurtbox.monitorable = true
	hurtbox.set_deferred("monitoring", true)
	state = WANDER


func _on_EnemyHurtbox_area_entered(area):
	stats.health -= area.damage
