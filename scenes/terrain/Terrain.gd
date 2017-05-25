const Tile = preload("res://scenes/room/Tile.gd")

static func _gen_terrain(w):
	var array = []
	for i in range(w+14):
		for j in range(w+10):
			array.push_back(Tile.new(i-(w/2)-7,j-(w/2)-5,Tile.WATER_0,0))
	for i in range(w):
		for j in range(w):
			array.push_back(Tile.new(i-(w/2),j-(w/2),Tile.GROUND,0))
	return array
	
func simplex(x,y):

    
    return (lerp (y1, y2, w)+1)/2;    
