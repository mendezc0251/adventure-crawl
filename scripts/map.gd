extends Node2D

@export var noise_height_texture : NoiseTexture2D
var noise : Noise

var width : int = 16
var height : int = 9

@onready var tile_map: TileMapLayer = $TileMapLayer
var source_id = 0
var water_atlas = Vector2i(0,1)
var land_atlas = Vector2i(3,1)
var path_atlas = Vector2i(0,0)
var woods_atlas = Vector2i(4,0)
var shop_atlas = Vector2i(3,0)
var village_atlas = Vector2i(2,1)
var hole_atlas = Vector2i(1,1)
var spore_atlas = Vector2i(2,0)
var grass_atlas = Vector2i(1,0)

func _ready() -> void:
	noise = noise_height_texture.noise
	generate_map()
	generate_path()
	place_buildings()
# function that randomly places tiles on the map
func generate_map():
	for x in range(width):
		for y in range(height):
			# get random number between 1 and 100.
			var randomNum = randi()%100+1
			# 10% chance to generate water tile
			if randomNum<=10:
				tile_map.set_cell(Vector2(x,y),source_id,water_atlas)
			# 10% chance to generate land tile
			elif randomNum>10 and randomNum<=20:
				tile_map.set_cell(Vector2(x,y),source_id,land_atlas)
			# 10% chance to generate woods tile
			elif randomNum>20 and randomNum<=30:
				tile_map.set_cell(Vector2(x,y),source_id,woods_atlas)
			# 5% chance to generate hole tile
			elif randomNum>30 and randomNum<=35:
				tile_map.set_cell(Vector2(x,y),source_id,hole_atlas)
			# 15% chance to generate spore tile
			elif randomNum>35 and randomNum<=50:
				tile_map.set_cell(Vector2(x,y),source_id,spore_atlas)
			# 50% chance to generate grass tile
			elif randomNum>50 and randomNum<=100:
				tile_map.set_cell(Vector2(x,y),source_id,grass_atlas)
				
				
# function that generates a path streatching from the left side of the map to the right side of the map
func generate_path():
	var x = 0
	var y = 4
	tile_map.set_cell(Vector2(x,y),source_id,path_atlas)
	while x<width-1:
		var randomNum = randi()%3
		print(randomNum)
		# up
		if randomNum==0:
			y+=1
			if y>=height:
				y-=1
				tile_map.set_cell(Vector2(x,y),source_id,path_atlas)
				x+=1
				tile_map.set_cell(Vector2(x,y),source_id,path_atlas)
			else:
				tile_map.set_cell(Vector2(x,y),source_id, path_atlas)
				x+=1
				tile_map.set_cell(Vector2(x,y), source_id, path_atlas)
		# down
		elif randomNum==1:
			y-=1
			if y<0:
				y+=1
				tile_map.set_cell(Vector2(x,y),source_id,path_atlas)
				x+=1
				tile_map.set_cell(Vector2(x,y),source_id,path_atlas)
			else:
				tile_map.set_cell(Vector2(x,y), source_id, path_atlas)
				x+=1
				tile_map.set_cell(Vector2(x,y), source_id, path_atlas)
		# right
		else:
			x+=1
			tile_map.set_cell(Vector2(x,y), source_id, path_atlas)
# function that places villages and shops on the map
func place_buildings():
	var placedShop = false
	var placedVillage = false
	while !placedShop:
		var randomX = randi()%width
		var randomY = randi()%height
		if tile_map.get_cell_atlas_coords(Vector2i(randomX,randomY))!=path_atlas and tile_map.get_cell_atlas_coords(Vector2i(randomX,randomY))!=village_atlas:
			tile_map.set_cell(Vector2(randomX,randomY), source_id, shop_atlas)
			placedShop=true
	while !placedVillage:
		var randomX = randi()%width
		var randomY = randi()%height
		if tile_map.get_cell_atlas_coords(Vector2i(randomX,randomY))!=path_atlas and tile_map.get_cell_atlas_coords(Vector2i(randomX,randomY))!=shop_atlas:
			tile_map.set_cell(Vector2(randomX,randomY), source_id, village_atlas)
			placedVillage=true
