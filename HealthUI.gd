extends Control

onready var hearts = 3 setget set_hearts
onready var max_hearts = 3 setget set_max_hearts

onready var emptyHeart = $EmptyHeart
onready var fullHeart = $FullHeart
onready var stats = PlayerStats

func _ready():
	self.hearts = stats.health
	self.max_hearts = stats.max_health
	stats.connect("health_changed", self, "set_hearts")
	stats.connect("max_health_changed", self, "set_max_hearts")

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if fullHeart != null:
		fullHeart.rect_size.x = hearts * 15
	
func set_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	if emptyHeart != null:
		emptyHeart.rect_size.x = max_hearts * 15
