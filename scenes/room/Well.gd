const Tile = preload("res://scenes/room/Tile.gd")

static func _gen_well(x,y):
	var array = []
	array.push_back(Tile.new(x, y, Tile.WELL_TOP,1))
	array.push_back(Tile.new(x, y, Tile.GROUND,0))
	array.push_back(Tile.new(x-1, y+1, Tile.GROUND,0))
	array.push_back(Tile.new(x+1, y+1, Tile.GROUND,0))
	array.push_back(Tile.new(x, y+1, Tile.WELL_BOTTOM,0))
	return array