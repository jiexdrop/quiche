extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var tween = get_node("Tween")
onready var sprite = get_node("Sprite")
onready var weapon = get_node("Sprite/Weapon")

var property = "transform/pos"
var speed = 300

func _attack():
	weapon._swing()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func _move_to(points, j):
	var start = sprite.get_pos()
	var end = points[j]
	j = j+1
	
	var distance = start.distance_to(end)
	var time = distance / speed
	if time <= 0: return
	if tween.is_active(): tween.stop(sprite, property)
	tween.interpolate_property(sprite, property, start, end, time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if j<points.size(): tween.interpolate_callback(self, time, "_move_to",points, j)
	tween.start()


