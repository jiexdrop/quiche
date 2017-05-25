extends Node

const room = preload("res://scenes/room/Room.gd")
const tile = preload("res://scenes/room/Tile.gd")
const well = preload("res://scenes/room/Well.gd")
const terrain = preload("res://scenes/terrain/FlatTerrain.gd")
const fill_tilemap = preload("res://scenes/util/FillTilemap.gd")

onready var tile_map = get_node("Navigation2D/TileMap")
onready var top_tile_map = get_node("Tops")
onready var player = get_node("Player/Sprite")
#to refactor
onready var node_player = get_node("Player")
onready var slime = load("res://scenes/enemies/Slimes.tscn")

onready var item = load("res://scenes/terrain/Item.tscn")

var enemies = []
var points = []

var scene_timer = Timer.new()

func _gen_level():
	fill_tilemap._fill_tilemap(tile_map,top_tile_map,terrain._gen_flat_terrain(Vector2(0,0),10))
	#fill_tilemap._fill_tilemap(tile_map,top_tile_map,room._gen_room(randi()%8-randi()%8,randi()%8-randi()%8,randi()%3+3,randi()%3+3))
	#fill_tilemap._fill_tilemap(tile_map,top_tile_map,room._gen_room(randi()%8-randi()%8,randi()%8-randi()%8,randi()%3+3,randi()%3+3))
	#fill_tilemap._fill_tilemap(tile_map,top_tile_map,well._gen_well(randi()%8-randi()%8,randi()%8-randi()%8))
	pass

func _gen_enemies():
	for i in range(30):
		enemies.push_back(slime.instance())
		enemies[i].set_pos(tile_map.map_to_world(Vector2(10+i,8)))
		add_child(enemies[i])
	pass

func _ready():
	# Initialization here
	randomize()
	_gen_level()
	_gen_enemies()
#	set_process(true)
	_set_scene_timer()
	set_process_input(true)
	
	
func _set_scene_timer():
	scene_timer.connect("timeout",self,"_update_scene") 
	add_child(scene_timer) #to process
	scene_timer.start() #to start
	pass

func _update_scene():
	#move monsters
	generate_map_arround_me()
	
	for enemy in enemies:
		if(enemy.is_hidden()):
			enemies.erase(enemy)
			enemy.queue_free()
		var player_pos = Vector2(player.get_pos().x + rand_range(-50,50), player.get_pos().y + rand_range(-50,50) )
		enemy._move_to(get_node("Navigation2D").get_simple_path(enemy._get_pos(), player_pos,  true),1)
	
	#generate win
	if (enemies.size()==0):
		var key = item.instance()
		key.set_pos(player.get_pos() + Vector2(50,0))
		add_child(key) 
	pass

func _input(event):
	var camera = get_node("Player/Sprite/Camera2D")
	var pos = event.pos
	pos.x = pos.x + (camera.get_camera_pos().x - (get_viewport().get_rect().size.x/2))
	pos.y = pos.y + (camera.get_camera_pos().y - (get_viewport().get_rect().size.y/2))
	
	if(event.type == InputEvent.SCREEN_TOUCH):
		if event.pressed:
			if(tile_map.get_cellv(tile_map.world_to_map(pos))==tile.VOID):
				tile_map.set_cellv(tile_map.world_to_map(pos), tile.GROUND)
			elif(tile_map.get_cellv(tile_map.world_to_map(pos))==tile.DOOR):
				tile_map.set_cellv(tile_map.world_to_map(pos), tile.DOOR_OPEN)
			elif(tile_map.get_cellv(tile_map.world_to_map(pos))==tile.DOOR_OPEN):
				tile_map.set_cellv(tile_map.world_to_map(pos), tile.DOOR)

			points = get_node("Navigation2D").get_simple_path(player.get_pos(), pos, true)
			if(points.size()>0):
				if(tile_map.get_cellv(tile_map.world_to_map(pos))==tile.GROUND):
					node_player._move_to(points,1)
				
	pass

#func _process(delta):
#	pass

func generate_map_arround_me():
	#What to do ?
	#Pass the same seed to generate the map
	#Get the playerpos and generate around him *
	#Save the position around *
	#It's maybe unnecessary to clear the position arround *
	
	#how to know i already fill ? -> save positions somewhere
	#if player is at potion %10==0 then add map
	fill_tilemap._fill_tilemap(tile_map,top_tile_map,terrain._gen_flat_terrain(player_chunk_position(0),10))
	fill_tilemap._fill_tilemap(tile_map,top_tile_map,terrain._gen_flat_terrain(player_chunk_position(1),10))
	fill_tilemap._fill_tilemap(tile_map,top_tile_map,terrain._gen_flat_terrain(player_chunk_position(2),10))
	fill_tilemap._fill_tilemap(tile_map,top_tile_map,terrain._gen_flat_terrain(player_chunk_position(2),10))
	
	pass

func player_chunk_position(w):
	var x = round(tile_map.world_to_map(player.get_pos()).x/10)*10
	var y = round(tile_map.world_to_map(player.get_pos()).y/10)*10
	if(w==0):
		return Vector2(x,y)
	elif(w==1):
		return Vector2(x-10,y)
	elif(w==2):
		return Vector2(x,y-10)
	else:
		return Vector2(x-10,y-10)


