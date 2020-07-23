extends KinematicBody2D

onready var ACCELERATION = 400
onready var FRICTION = 400
onready var MAX_SPEED = 100

onready var facing_direction = Vector2.RIGHT
onready var velocity = Vector2.ZERO

onready var mouse_sensitivity = 0.002
onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
onready var stats = PlayerStats

signal player_died

func _ready():
	stats.live = true
	stats.set_max_health(3)
	stats.set_health(3)
	stats.connect("no_health", self, "on_no_health")

# warning-ignore:unused_argument
func _physics_process(delta):
	facing_direction = Vector2.RIGHT if get_local_mouse_position().x >= 0 else Vector2.LEFT
	
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	direction = direction.normalized()
	
	if direction != Vector2.ZERO:
		animationPlayer.play("Run")
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION)
	else:
		animationPlayer.play("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
	
	update_position()


func update_position():
	sprite.flip_h = facing_direction == Vector2.LEFT
# warning-ignore:return_value_discarded
	move_and_slide(velocity)


func on_no_health():
	emit_signal("player_died")
	stats.live = false
	queue_free()

func _on_PlayerHurtbox_area_entered(area):
	stats.health -= area.damage
