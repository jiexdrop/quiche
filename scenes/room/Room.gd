const Tile = preload("res://scenes/room/Tile.gd")

static func _gen_room(x,y,w,h):
	var array = []
	for i in range(w):
		for j in range(h):
			array.push_back(Tile.new(i+x,j+y,Tile.WALL,0))
	for i in range(w-2):
		for j in range(h-2):
			array.push_back(Tile.new(i+x+1,j+y+1,Tile.GROUND,0))
	
	randomize()
	var door = randi()%(w-2)
	
	array.push_back(Tile.new(x+door+1,y+h-1,Tile.DOOR,0))
	return array
