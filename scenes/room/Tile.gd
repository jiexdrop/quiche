var point
var type
var z_index

const WELL_TOP = 0

const VOID = -1
const GROUND = 0
const WALL = 1
const DOOR = 2
const DOOR_OPEN = 3
const TREASURE = 4
const VOID_GROUND = 5
const WELL_BOTTOM = 6
const WATER_0 = 7

func _init(x, y, t, z):
	point = Vector2(x,y)
	type = t
	z_index = z
