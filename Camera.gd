extends Camera2D

onready var topleft = $Node/TopLeft
onready var bottomright = $Node/BottomRight

# warning-ignore:unused_argument
func _physics_process(delta):
	limit_left = topleft.position.x
	limit_top = topleft.position.y
	limit_bottom = bottomright.position.y
	limit_right = bottomright.position.x
