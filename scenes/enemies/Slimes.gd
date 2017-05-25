extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var property = "transform/pos"
var speed = 50

onready var tween = get_node("Tween")
onready var sprite = get_node("Sprite")
onready var collision_shape = get_node("CollisionShape2D")

func _set_pos(point):
	self.set_pos(point)
	collision_shape.set_pos(point)

func _ready():
	pass
	
func _get_pos():
	return self.get_pos()

func _move_to(points, j):
	var start = self.get_pos()
	if tween.is_active(): tween.stop(self, property)
	if(points.size() > 0):
		var end = points[j]
		j = j+1
	
		var distance = start.distance_to(end)
		var time = distance / speed
		if time <= 0: return
		tween.interpolate_property(self, property, start, end, time, Tween.TRANS_LINEAR, Tween.EASE_IN)
		if j<points.size(): tween.interpolate_callback(self, time, "_move_to", points, j)
		tween.start()
	

func _input_event(viewport, event, shape_idx):
	if(event.type == InputEvent.SCREEN_TOUCH) \
	and event.pressed:
		self.hide()