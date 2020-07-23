extends AnimatedSprite

func _ready():
# warning-ignore:return_value_discarded
	connect("animation_finished", self, "on_animation_finished")
	play("Animated")

func on_animation_finished():
	queue_free()
