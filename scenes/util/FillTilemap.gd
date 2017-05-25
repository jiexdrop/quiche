static func _fill_tilemap(background_map, foreground_map, tile_array):
	for cell in tile_array:
		if(cell.z_index==0):
			background_map.set_cellv(cell.point, cell.type)
		elif(cell.z_index==1):
			foreground_map.set_cellv(cell.point, cell.type)