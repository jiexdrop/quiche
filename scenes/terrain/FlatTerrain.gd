const Tile = preload("res://scenes/room/Tile.gd")

static func _gen_flat_terrain(vec2,w):
	var array = []
	for i in range(w):
		for j in range(w):
			array.push_back(Tile.new(i+vec2.x,j+vec2.y,Tile.GROUND,0))
	return array